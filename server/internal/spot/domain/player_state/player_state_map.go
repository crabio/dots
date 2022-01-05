package player_state

import (
	"sync"

	"github.com/google/uuid"
)

type PlayerStateMap struct {
	sync.RWMutex
	internal map[uuid.UUID]*PlayerState
}

func NewPlayerStateMap() *PlayerStateMap {
	return &PlayerStateMap{
		internal: make(map[uuid.UUID]*PlayerState),
	}
}

func (m *PlayerStateMap) Load(key uuid.UUID) (value *PlayerState, ok bool) {
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

func (m *PlayerStateMap) Range(f func(k uuid.UUID, v *PlayerState)) {
	m.Lock()
	for k, v := range m.internal {
		f(k, v)
	}
	m.Unlock()
}

func (m *PlayerStateMap) Store(key uuid.UUID, value *PlayerState) {
	m.Lock()
	m.internal[key] = value
	m.Unlock()
}
