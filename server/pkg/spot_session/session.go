package spot_session

import (
	"sync"
	"time"

	"github.com/golang/geo/s2"
	"github.com/google/uuid"
	"github.com/iakrevetkho/dots/server/pkg/damage"
	"github.com/iakrevetkho/dots/server/pkg/game_controller"
	"github.com/iakrevetkho/dots/server/pkg/player_state"
	"github.com/iakrevetkho/dots/server/pkg/zone"
	"github.com/tjgq/broadcast"
)

type SpotSession struct {
	sync.RWMutex

	ZoneController *zone.Controller

	Controller *damage.Controller

	GameController *game_controller.GameController
	// Channel for sending game event (one of StartGameEvent, EndGameEvent)
	GameEventBroadcaster *broadcast.Broadcaster
	LastGameEvent        interface{}

	// Map with players posiiton
	//
	// key - player uuid
	// value - player state
	PlayersStateMap *player_state.PlayerStateMap
}

func NewSpotSession(spotPosition s2.LatLng, spotRadiusInM float32, nextZonePeriod time.Duration, duration time.Duration) *SpotSession {
	ss := new(SpotSession)
	ss.ZoneController = zone.NewController(spotPosition, spotRadiusInM, 10, nextZonePeriod, 15*time.Second, 20.0)
	ss.GameController = game_controller.NewGameController(duration)
	ss.GameEventBroadcaster = broadcast.New(0)

	return ss
}

func (ss *SpotSession) Start(hunterUuid uuid.UUID, playersList []uuid.UUID) error {
	ss.PlayersStateMap = player_state.NewPlayerStateMap()
	for _, playerUuid := range playersList {
		playerState := player_state.NewPlayerState()
		ss.PlayersStateMap.Store(playerUuid, playerState)
	}

	ss.Controller = damage.NewDamageController(ss.ZoneController.ZoneEventBroadcaster, ss.PlayersStateMap)

	// Start game
	ss.GameController.Start(hunterUuid)

	// Send and save StartGameEvent
	ss.sendStartGameEvent()

	// Start zone ticker
	if err := ss.ZoneController.Start(); err != nil {
		return err
	}

	return nil
}

func (ss *SpotSession) NewPlayersState(key uuid.UUID, value *player_state.PlayerState) error {
	ss.PlayersStateMap.Store(key, value)

	// Send new player position to damage controller
	ss.Controller.NewPlayerState(key, value)

	event, err := ss.GameController.Check(ss.PlayersStateMap)
	if err != nil {
		return err
	}

	// Check that we have event
	if event != nil {
		ss.sendEndGameEvent(event)
	}

	return nil
}

func (ss *SpotSession) sendStartGameEvent() {
	event := game_controller.StartGameEvent{}
	ss.LastGameEvent = event

	// Broadcast event
	ss.GameEventBroadcaster.Send(event)
}

func (ss *SpotSession) sendEndGameEvent(event *game_controller.EndGameEvent) {
	ss.LastGameEvent = *event

	// Broadcast event
	ss.GameEventBroadcaster.Send(event)
}
