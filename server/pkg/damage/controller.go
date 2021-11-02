package damage

import (
	"time"

	"github.com/google/uuid"
	"github.com/iakrevetkho/dots/server/pkg/player_state"
	"github.com/iakrevetkho/dots/server/pkg/spot_session"
	"github.com/iakrevetkho/dots/server/pkg/utils/geo"
	"github.com/iakrevetkho/dots/server/pkg/zone"
	"github.com/sirupsen/logrus"
	"github.com/tjgq/broadcast"
)

const zoneDamagePeriod = time.Second * 2

// Damage controller performs damage function if player is out of zone
type DamageController struct {
	currentZone *zone.Zone

	// Channel for receiving zone event (one of NextZone, NextZoneTick, ZoneTickEnd)
	zoneEventBroadcaster *broadcast.Broadcaster

	// Spot session is required for checking all current players location on new zone
	spotSession *spot_session.SpotSession

	playerDamageTickerMap *PlayerDamageTickerMap
}

func NewDamageController(zoneEventBroadcaster *broadcast.Broadcaster, spotSession *spot_session.SpotSession) *DamageController {
	c := new(DamageController)
	c.zoneEventBroadcaster = zoneEventBroadcaster
	c.spotSession = spotSession
	c.playerDamageTickerMap = NewPlayerDamageTickerMap()
	return c
}

func (c *DamageController) subOnZoneEvents() {
	for zoneEventI := range c.zoneEventBroadcaster.Listen().Ch {
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
	}

	// On new zone event controller should check all users in new zone
	c.spotSession.PlayersStateMap.Range(func(k uuid.UUID, v *player_state.PlayerState) {
		c.NewPlayerState(k, v)
	})
}

func (c *DamageController) NewZone(zone *zone.Zone) {
	c.currentZone = zone
}

// Function trigger indicator about new player position for damage conditions check
func (c *DamageController) NewPlayerState(playerUuid uuid.UUID, playerState *player_state.PlayerState) {
	// Check player damage ticker in map
	damageTicker, ok := c.playerDamageTickerMap.Load(playerUuid)

	// Check damage condition
	if geo.AngleToM(playerState.Position.Distance(c.currentZone.Position)) > float64(c.currentZone.Radius) {
		if c.currentZone != nil {
			if !ok {
				damageTicker := time.NewTicker(zoneDamagePeriod)
				c.playerDamageTickerMap.Store(playerUuid, damageTicker)

				// Start goroutine for damage on each ticker tick
				go func() {
					// TODO Check what will happen if ticker wiil be stop
					for range damageTicker.C {
						logrus.Debug("Damage ticker tick")
						playerState.Lock()
						playerState.Health = playerState.Health - c.currentZone.Damage
						playerState.Unlock()

						playerState.Broadcaster.Send(player_state.PlayerPublicState{
							PlayerUuid: playerUuid,
							Position:   playerState.Position,
							Health:     playerState.Health,
						})
					}
					logrus.Debug("Exit from damage ticker loop")
				}()
			}
		}
	} else {
		if ok {
			damageTicker.Stop()
			c.playerDamageTickerMap.Delete(playerUuid)
		}
	}
}
