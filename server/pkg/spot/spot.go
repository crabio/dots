package spot

import (
	"sync"
	"time"

	"github.com/golang/geo/s2"
	"github.com/google/uuid"
	"github.com/iakrevetkho/dots/server/pkg/damage"
	"github.com/iakrevetkho/dots/server/pkg/game_controller"
	"github.com/iakrevetkho/dots/server/pkg/spot_session"
	"github.com/iakrevetkho/dots/server/pkg/zone"
	"github.com/tjgq/broadcast"
)

type Spot struct {
	Id uuid.UUID

	Position        s2.LatLng
	RadiusInM       float32
	ScanPeriod      time.Duration
	ZonePeriod      time.Duration
	SessionDuration time.Duration

	PlayersList []uuid.UUID
	// Channel for sending players list on update
	PlayersListBroadcaster *broadcast.Broadcaster

	Session *spot_session.SpotSession

	ZoneController *zone.Controller

	DamageController *damage.DamageController

	GameController *game_controller.GameController

	// Channel for sending start/stop flags
	IsActiveBroadcaster *broadcast.Broadcaster
}

func NewSpot(position s2.LatLng, radiusInM float32, scanPeriod time.Duration, zonePeriod time.Duration, sessionDuration time.Duration) *Spot {
	spot := new(Spot)
	spot.Id = uuid.New()
	spot.Position = position
	spot.RadiusInM = radiusInM
	spot.ScanPeriod = scanPeriod
	spot.ZonePeriod = zonePeriod
	spot.SessionDuration = sessionDuration
	spot.PlayersListBroadcaster = broadcast.New(0)
	spot.IsActiveBroadcaster = broadcast.New(0)
	spot.ZoneController = zone.NewController(spot.Id, position, radiusInM, 10, zonePeriod, 15*time.Second, 20.0)
	spot.GameController = game_controller.NewGameController()

	return spot
}

type SpotMap struct {
	sync.RWMutex
	internal map[uuid.UUID]Spot
}

func NewSpotMap() *SpotMap {
	return &SpotMap{
		internal: make(map[uuid.UUID]Spot),
	}
}

func (m *SpotMap) Load(key uuid.UUID) (value Spot, ok bool) {
	m.RLock()
	result, ok := m.internal[key]
	m.RUnlock()
	return result, ok
}

func (m *SpotMap) Delete(key uuid.UUID) {
	m.Lock()
	delete(m.internal, key)
	m.Unlock()
}

func (m *SpotMap) Store(key uuid.UUID, value Spot) {
	m.Lock()
	m.internal[key] = value
	m.Unlock()
}
