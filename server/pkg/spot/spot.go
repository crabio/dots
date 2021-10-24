package spot

import (
	// External
	"sync"
	"time"

	"github.com/golang/geo/s2"
	"github.com/google/uuid"

	// Internal
	"github.com/iakrevetkho/dots/server/pkg/player_state"
)

type Spot struct {
	Position s2.LatLng
	// Zone radius in meters
	ZoneRadius      int32
	ScanPeriod      time.Duration
	ZonePeriod      time.Duration
	SessionDuration time.Duration

	// Map with players posiiton
	//
	// key - player uuid
	// value - player state
	PlayersStateMap *player_state.PlayerStateMap

	// Fla indicies that spot is active (players are playing)
	IsActive bool
}

func NewSpot(position s2.LatLng, zoneRadius int32, scanPeriod time.Duration, zonePeriod time.Duration, sessionDuration time.Duration) *Spot {
	spot := new(Spot)
	spot.Position = position
	spot.ZoneRadius = zoneRadius
	spot.ScanPeriod = scanPeriod
	spot.ZonePeriod = zonePeriod
	spot.SessionDuration = sessionDuration

	spot.PlayersStateMap = player_state.NewPlayerStateMap()
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
