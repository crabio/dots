package spot

import (
	// External
	"sync"
	"time"

	"github.com/golang/geo/s2"
	"github.com/google/uuid"
	"github.com/tjgq/broadcast"
	// Internal
)

type Spot struct {
	Position s2.LatLng
	// Zone radius in meters
	ZoneRadius      int32
	ScanPeriod      time.Duration
	ZonePeriod      time.Duration
	SessionDuration time.Duration

	PlayersList []uuid.UUID
	// Channel for sending players list on update
	PlayersListBroadcaster *broadcast.Broadcaster

	Session *SpotSession

	// Fla indicies that spot is active (players are playing)
	IsActive bool
	// Channel for sending start/stop flags
	IsActiveBroadcaster *broadcast.Broadcaster
}

func NewSpot(position s2.LatLng, zoneRadius int32, scanPeriod time.Duration, zonePeriod time.Duration, sessionDuration time.Duration) *Spot {
	spot := new(Spot)
	spot.Position = position
	spot.ZoneRadius = zoneRadius
	spot.ScanPeriod = scanPeriod
	spot.ZonePeriod = zonePeriod
	spot.SessionDuration = sessionDuration
	spot.PlayersListBroadcaster = broadcast.New(0)
	spot.IsActiveBroadcaster = broadcast.New(0)

	spot.IsActive = false

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