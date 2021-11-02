package damage

import (
	// External
	"sync"
	"time"

	"github.com/google/uuid"
	// Internal
)

type PlayerDamageTickerMap struct {
	sync.RWMutex
	internal map[uuid.UUID]*time.Ticker
}

func NewPlayerDamageTickerMap() *PlayerDamageTickerMap {
	return &PlayerDamageTickerMap{
		internal: make(map[uuid.UUID]*time.Ticker),
	}
}

func (m *PlayerDamageTickerMap) Load(key uuid.UUID) (value *time.Ticker, ok bool) {
	m.RLock()
	result, ok := m.internal[key]
	m.RUnlock()
	return result, ok
}

func (m *PlayerDamageTickerMap) Delete(key uuid.UUID) {
	m.Lock()
	delete(m.internal, key)
	m.Unlock()
}

func (m *PlayerDamageTickerMap) Range(f func(k uuid.UUID, v *time.Ticker)) {
	m.Lock()
	for k, v := range m.internal {
		f(k, v)
	}
	m.Unlock()
}

func (m *PlayerDamageTickerMap) Store(key uuid.UUID, value *time.Ticker) {
	m.Lock()
	m.internal[key] = value
	m.Unlock()
}
