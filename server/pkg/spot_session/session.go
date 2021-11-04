package spot_session

import (
	// External

	"time"

	"github.com/golang/geo/s2"
	"github.com/google/uuid"

	// Internal
	"github.com/iakrevetkho/dots/server/pkg/damage"
	"github.com/iakrevetkho/dots/server/pkg/game_controller"
	"github.com/iakrevetkho/dots/server/pkg/player_state"
	"github.com/iakrevetkho/dots/server/pkg/zone"
)

type SpotSession struct {
	Duration time.Duration

	ZoneController *zone.Controller

	DamageController *damage.DamageController

	GameController *game_controller.GameController

	// Map with players posiiton
	//
	// key - player uuid
	// value - player state
	PlayersStateMap *player_state.PlayerStateMap
}

func NewSpotSession(spotPosition s2.LatLng, spotRadiusInM float32, nextZonePeriod time.Duration, duration time.Duration, playersList []uuid.UUID) *SpotSession {
	ss := new(SpotSession)
	ss.Duration = duration
	ss.PlayersStateMap = player_state.NewPlayerStateMap()
	for _, playerUuid := range playersList {
		playerState := player_state.NewPlayerState()
		ss.PlayersStateMap.Store(playerUuid, playerState)
	}

	ss.ZoneController = zone.NewController(spotPosition, spotRadiusInM, 10, nextZonePeriod, 15*time.Second, 20.0)
	ss.GameController = game_controller.NewGameController()
	ss.DamageController = damage.NewDamageController(ss.ZoneController.ZoneEventBroadcaster, ss.PlayersStateMap)

	return ss
}

func (ss *SpotSession) Start(hunterUuid uuid.UUID) error {
	ss.GameController.Start(hunterUuid)

	// Start zone ticker
	if err := ss.ZoneController.Start(); err != nil {
		return err
	}

	return nil
}

func (ss *SpotSession) PlayersStateMapStore(key uuid.UUID, value *player_state.PlayerState) error {
	ss.PlayersStateMap.Store(key, value)

	// Send new player position to damage controller
	ss.DamageController.NewPlayerState(key, value)

	if err := ss.GameController.Check(ss.Duration, ss.PlayersStateMap); err != nil {
		return err
	}

	return nil
}
