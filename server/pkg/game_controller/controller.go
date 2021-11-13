package game_controller

import (
	"errors"
	"sync"
	"time"

	"github.com/google/uuid"
	"github.com/iakrevetkho/archaeopteryx/logger"
	"github.com/iakrevetkho/dots/server/pkg/player_state"
	"github.com/sirupsen/logrus"
)

// Functions as variable required for unit tests
var (
	timeNow = time.Now
	// This mutex is required to prevent race in unit tests
	timeNowMx = sync.RWMutex{}
)

type GameController struct {
	sync.RWMutex

	log *logrus.Entry

	// UUID of hunter player
	HunterUuid *uuid.UUID

	StartTime *time.Time

	// Flag indicies that game is active
	IsActive bool
}

func NewGameController() *GameController {
	c := new(GameController)
	c.log = logger.CreateLogger("game-controller")
	return c
}

func (c *GameController) Start(hunterUuid uuid.UUID) {
	c.Lock()
	c.IsActive = true
	c.log.Debugf("GameController(%v) acive:%v", c, c.IsActive)
	timeNow := timeNow().UTC()
	c.StartTime = &timeNow
	c.HunterUuid = &hunterUuid
	c.Unlock()
}

// Function checks current spot session status
//
// Hunter wins if all players are death or caught
//
// Victims win if
// 1. hunter is death and at least one of victim alive
// 2. or time if over and at least one of victim alive
func (c *GameController) Check(sessionDuration time.Duration, playerStateMap *player_state.PlayerStateMap) (*EndGameEvent, error) {
	c.log.Debugf("GameController(%v) acive:%v", c, c.IsActive)
	if !c.IsActive {
		return nil, errors.New("Game session is not active")
	}

	if c.StartTime == nil {
		return nil, errors.New("Start time is not set yer")
	}

	if c.HunterUuid == nil {
		return nil, errors.New("HunterUuid is not inited yet")
	}

	hunterState, ok := playerStateMap.Load(*c.HunterUuid)
	if !ok {
		return nil, errors.New("Couldn't load hunter player state from PlayersStateMap")
	}

	// Check victims states
	alivePlayersStates := getAlivePlayers(playerStateMap, *c.HunterUuid)

	c.Lock()
	defer c.Unlock()
	if hunterState.Health == 0 {
		// Hunter is dead
		if len(alivePlayersStates) > 0 {
			// 1. hunter is death and at least one of victim alive
			c.log.Debug("Victims wins")
			event := EndGameEvent{
				Winner: SessionWinner_VictimsWins,
			}
			c.stop()
			return &event, nil
		} else {
			// Hunter and player are dead => draw
			c.log.Debug("Draw")
			event := EndGameEvent{
				Winner: SessionWinner_Draw,
			}
			c.stop()
			return &event, nil
		}

	} else {
		// Hunter is alive

		if len(alivePlayersStates) > 0 {
			// 1. hunter is death and at least one of victim alive

			// Check session time
			if c.StartTime.Add(sessionDuration).Before(time.Now().UTC()) {
				// 2. or time if over and at least one of victim alive
				c.log.Debug("Victims wins")
				event := EndGameEvent{
					Winner: SessionWinner_VictimsWins,
				}
				c.stop()
				return &event, nil
			}
		} else {
			// Hunter is alive and players are dead
			c.log.Debug("Hunter win")
			event := EndGameEvent{
				Winner: SessionWinner_HunterWins,
			}
			c.stop()
			return &event, nil
		}
	}

	return nil, nil
}

func (c *GameController) stop() {
	c.IsActive = false
	c.StartTime = nil
	c.HunterUuid = nil
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
