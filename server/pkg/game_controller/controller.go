package game_controller

import (
	"errors"
	"time"

	"github.com/google/uuid"
	"github.com/iakrevetkho/archaeopteryx/logger"
	"github.com/iakrevetkho/dots/server/pkg/player_state"
	"github.com/iakrevetkho/dots/server/pkg/zone"
	"github.com/sirupsen/logrus"
	"github.com/tjgq/broadcast"
)

type GameController struct {
	log *logrus.Entry

	// UUID of hunter player
	HunterUuid *uuid.UUID

	StartTime *time.Time

	// Flag indicies that game is active
	IsActive bool

	EventsBroadcaster *broadcast.Broadcaster

	zoneController *zone.Controller
}

func NewGameController(zoneController *zone.Controller) *GameController {
	c := new(GameController)
	c.log = logger.CreateLogger("game-controller")
	c.EventsBroadcaster = broadcast.New(0)
	c.zoneController = zoneController
	return c
}

func (c *GameController) Start(hunterUuid uuid.UUID) {
	c.IsActive = true
	c.EventsBroadcaster.Send(StartSessionEvent{})
	timeNow := time.Now().UTC()
	c.StartTime = &timeNow
	c.HunterUuid = &hunterUuid
}

// Function checks current spot session status
//
// Hunter wins if all players are death or caught
//
// Victims win if
// 1. hunter is death and at least one of victim alive
// 2. or time if over and at least one of victim alive
func (c *GameController) Check(sessionDuration time.Duration, playerStateMap *player_state.PlayerStateMap) error {
	if !c.IsActive {
		return errors.New("Game session is not active")
	}

	if c.StartTime == nil {
		return errors.New("Start time is not set yer")
	}

	if c.HunterUuid == nil {
		return errors.New("HunterUuid is not inited yet")
	}

	hunterState, ok := playerStateMap.Load(*c.HunterUuid)
	if !ok {
		return errors.New("Couldn't load hunter player state from PlayersStateMap")
	}

	// Check victims states
	alivePlayersStates := getAlivePlayers(playerStateMap, *c.HunterUuid)

	if hunterState.Health == 0 {
		// Hunter is dead
		if len(alivePlayersStates) > 0 {
			// 1. hunter is death and at least one of victim alive
			c.log.Debug("Victims wins")
			c.EventsBroadcaster.Send(EndSessionEvent{
				Winner: SessionWinner_VictimsWins,
			})
		} else {
			// Hunter and player are dead => draw
			c.log.Debug("Draw")
			c.EventsBroadcaster.Send(EndSessionEvent{
				Winner: SessionWinner_Draw,
			})
		}
		c.stop()

	} else {
		// Hunter is alive

		if len(alivePlayersStates) > 0 {
			// 1. hunter is death and at least one of victim alive

			// Check session time
			if c.StartTime.Add(sessionDuration).Before(time.Now().UTC()) {
				// 2. or time if over and at least one of victim alive
				c.log.Debug("Victims wins")
				c.EventsBroadcaster.Send(EndSessionEvent{
					Winner: SessionWinner_VictimsWins,
				})
				c.stop()
			}
		} else {
			// Hunter is alive and players are dead
			c.log.Debug("Hunter win")
			c.EventsBroadcaster.Send(EndSessionEvent{
				Winner: SessionWinner_HunterWins,
			})
			c.stop()
		}
	}

	return nil
}

func (c *GameController) stop() {
	c.IsActive = false
	c.StartTime = nil
	c.HunterUuid = nil
	c.zoneController.Stop()

}

func getAlivePlayers(playersStateMap *player_state.PlayerStateMap, hunterUuid uuid.UUID) []*player_state.PlayerState {
	result := []*player_state.PlayerState{}

	playersStateMap.Range(func(k uuid.UUID, v *player_state.PlayerState) {
		// Filter non hunter players
		if k != hunterUuid {
			if v.Health > 0 && !v.IsCaught {
				result = append(result, v)
			}
		}
	})

	return result
}
