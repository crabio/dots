package game_controller

import (
	"errors"
	"time"

	"github.com/google/uuid"
	"github.com/iakrevetkho/dots/server/pkg/player_state"
	"github.com/iakrevetkho/dots/server/pkg/spot_session"
	"github.com/tjgq/broadcast"
)

type GameController struct {
	// Flag indicies that game is active
	IsActive          bool
	EventsBroadcaster *broadcast.Broadcaster
}

func NewGameController() *GameController {
	c := new(GameController)
	c.EventsBroadcaster = broadcast.New(0)
	return c
}

func (c *GameController) Start() {
	c.IsActive = true
	c.EventsBroadcaster.Send(StartSessionEvent{})
}

// Function checks current spot session status
//
// Hunter wins if all players are death or caught
//
// Victims win if
// 1. hunter is death and at least one of victim alive
// 2. or time if over and at least one of victim alive
func (c *GameController) Check(spotSession *spot_session.SpotSession) error {
	// Check that session is started
	if spotSession.StartTime == nil {
		return errors.New("Session is not started yet")
	}

	hunterState, ok := spotSession.PlayersStateMap.Load(spotSession.HunterUuid)
	if !ok {
		return errors.New("Couldn't load hunter player state from PlayersStateMap")
	}

	// Check victims states
	alivePlayersStates := getAlivePlayers(spotSession.PlayersStateMap, spotSession.HunterUuid)

	if hunterState.Health == 0 {
		// Hunter is dead
		if len(alivePlayersStates) > 0 {
			// 1. hunter is death and at least one of victim alive
			c.EventsBroadcaster.Send(EndSessionEvent{
				Winner: SessionWinner_VictimsWins,
			})
		} else {
			// Hunter and player are dead => draw
			c.EventsBroadcaster.Send(EndSessionEvent{
				Winner: SessionWinner_Draw,
			})
		}
		c.IsActive = false

	} else {
		// Hunter is alive

		if len(alivePlayersStates) > 0 {
			// 1. hunter is death and at least one of victim alive

			// Check session time
			if spotSession.StartTime.Add(spotSession.Duration).Before(time.Now().UTC()) {
				// 2. or time if over and at least one of victim alive
				c.EventsBroadcaster.Send(EndSessionEvent{
					Winner: SessionWinner_VictimsWins,
				})
				c.IsActive = false
			}
		} else {
			// Hunter is alive and players are dead
			c.EventsBroadcaster.Send(EndSessionEvent{
				Winner: SessionWinner_HunterWins,
			})
			c.IsActive = false
		}
	}

	return nil
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
