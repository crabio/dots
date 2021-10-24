package spot

import (
	// External
	"sync"
	"time"

	"github.com/golang/geo/s2"
	"github.com/google/uuid"
	"github.com/looplab/fsm"

	// Internal
	"github.com/iakrevetkho/dots/server/pkg/player_state"
)

type Spot struct {
	Position s2.LatLng
	// Zone radius in meters
	ZoneRadius int32
	ScanPeriod time.Duration
	ZonePeriod time.Duration
	// Map with players posiiton
	//
	// key - player uuid
	// value - player state
	PlayersStateMap *player_state.PlayerStateMap

	FSM *fsm.FSM
}

func NewSpot(position s2.LatLng, zoneRadius int32, scanPeriod time.Duration, zonePeriod time.Duration) *Spot {
	spot := new(Spot)
	spot.Position = position
	spot.ZoneRadius = zoneRadius
	spot.ScanPeriod = scanPeriod
	spot.ZonePeriod = zonePeriod
	spot.PlayersStateMap = player_state.NewPlayerStateMap()
	spot.FSM = fsm.NewFSM(
		"idle",
		fsm.Events{
			{Name: "start", Src: []string{"idle"}, Dst: "playing"},
			{Name: "finish", Src: []string{"playing"}, Dst: "idle"},
		},
		fsm.Callbacks{},
	)

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
