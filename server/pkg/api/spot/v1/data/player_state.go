package api_spot_v1_data

import (
	// External
	"sync"

	"github.com/golang/geo/s2"
	"github.com/google/uuid"
	// Internal
)

type PlayerState struct {
	Position s2.LatLng
	Health   int16

	// Zone damage

	// Flag indicies that server has goroutine for zone damage for player
	ZoneDamageActice bool
	// Channel for stoping damage by zone onto player
	StopZoneDmgCh chan bool

	// Channel for sending state about players states
	Sub *chan PlayerPublicState
}

type PlayerStateMap struct {
	sync.RWMutex
	internal map[uuid.UUID]PlayerState
}

func NewPlayerStateMap() *PlayerStateMap {
	return &PlayerStateMap{
		internal: make(map[uuid.UUID]PlayerState),
	}
}

func (m *PlayerStateMap) Load(key uuid.UUID) (value PlayerState, ok bool) {
	m.RLock()
	result, ok := m.internal[key]
	m.RUnlock()
	return result, ok
}

func (m *PlayerStateMap) Delete(key uuid.UUID) {
	m.Lock()
	delete(m.internal, key)
	m.Unlock()
}

func (m *PlayerStateMap) Range(f func(k uuid.UUID, v PlayerState)) {
	m.Lock()
	for k, v := range m.internal {
		f(k, v)
	}
	m.Unlock()
}

func (m *PlayerStateMap) Store(key uuid.UUID, value PlayerState) {
	m.Lock()
	m.internal[key] = value
	m.Unlock()
}

type PlayerPublicState struct {
	PlayerUuid uuid.UUID
	Position   s2.LatLng
	Health     int16
}
