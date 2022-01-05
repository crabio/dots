package spot

import (
	"sync"

	"github.com/google/uuid"
)

type SpotMap struct {
	sync.RWMutex
	internal map[uuid.UUID]*Spot
}

func NewSpotMap() *SpotMap {
	return &SpotMap{
		internal: make(map[uuid.UUID]*Spot),
	}
}

// TODO Use when all players leave spot
func (s *Spot) Close() {
	s.log.Debug("Close PlayersListBroadcaster")
	s.PlayersListBroadcaster.Close()
}

func (m *SpotMap) Load(key uuid.UUID) (value *Spot, ok bool) {
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

func (m *SpotMap) Store(key uuid.UUID, value *Spot) {
	m.Lock()
	m.internal[key] = value
	m.Unlock()
}
