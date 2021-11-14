package damage

import (
	"sync"
	"time"

	"github.com/google/uuid"
	"github.com/iakrevetkho/dots/server/pkg/player_state"
	"github.com/iakrevetkho/dots/server/pkg/utils/geo"
	"github.com/iakrevetkho/dots/server/pkg/zone"
	"github.com/sirupsen/logrus"
	"github.com/tjgq/broadcast"
)

const zoneDamagePeriod = time.Second * 2

// Damage controller performs damage function if player is out of zone
type Controller struct {
	sync.RWMutex

	currentZone *zone.Zone

	// Channel for receiving zone event (one of NextZone, NextZoneTick, ZoneTickEnd)
	zoneEventBroadcaster *broadcast.Broadcaster

	playerDamageTickerMap *PlayerDamageTickerMap
}

func NewDamageController(zoneEventBroadcaster *broadcast.Broadcaster, playersStateMap *player_state.PlayerStateMap) *Controller {
	c := new(Controller)
	c.zoneEventBroadcaster = zoneEventBroadcaster
	c.playerDamageTickerMap = NewPlayerDamageTickerMap()
	c.subOnZoneEvents(playersStateMap)
	return c
}

func (c *Controller) subOnZoneEvents(playersStateMap *player_state.PlayerStateMap) {
	go func() {
		for zoneEventI := range c.zoneEventBroadcaster.Listen().Ch {
			c.Lock()
			switch event := zoneEventI.(type) {
			case zone.StartNextZoneTimerEvent:
				c.currentZone = event.CurrentZone

			case zone.StartZoneDelayTimerEvent:
				c.currentZone = event.CurrentZone

			case zone.ZoneTickEvent:
				c.currentZone = event.CurrentZone

			default:
				logrus.Fatalf("Unimplemented zone event type: %v", event)
			}
			c.Unlock()

			// On new zone event controller should check all users in new zone
			playersStateMap.Range(func(k uuid.UUID, v *player_state.PlayerState) {
				c.NewPlayerState(k, v)
			})
		}
	}()
}

// Function trigger indicator about new player position for damage conditions check
func (c *Controller) NewPlayerState(playerUuid uuid.UUID, playerState *player_state.PlayerState) {
	// Check player damage ticker in map
	damageTicker, ok := c.playerDamageTickerMap.Load(playerUuid)

	// Check damage condition
	c.Lock()
	if c.currentZone != nil {
		if geo.AngleToM(playerState.Position.Distance(c.currentZone.Position)) > float64(c.currentZone.Radius) {
			if !ok {
				damageTicker := time.NewTicker(zoneDamagePeriod)
				c.playerDamageTickerMap.Store(playerUuid, damageTicker)

				// Start goroutine for damage on each ticker tick
				go func() {
					// TODO Check what will happen if ticker wiil be stop
					for range damageTicker.C {
						c.Lock()
						if playerState.Health < c.currentZone.Damage {
							playerState.Health = 0
						} else {
							playerState.Health = playerState.Health - c.currentZone.Damage
						}
						c.Unlock()

						// Check that player state broadcaster is exists
						if playerState.Broadcaster == nil {
							break
						}

						playerState.Broadcaster.Send(player_state.PlayerPublicState{
							PlayerUuid: playerUuid,
							Position:   playerState.Position,
							Health:     playerState.Health,
						})

						// Exit on death
						if playerState.Health == 0 {
							break
						}
					}
				}()
			}
		} else {
			if ok {
				damageTicker.Stop()
				c.playerDamageTickerMap.Delete(playerUuid)
			}
		}
	}
	c.Unlock()
}
