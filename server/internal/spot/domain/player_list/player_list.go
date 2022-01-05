package player_list

import (
	"sync"

	"github.com/google/uuid"
)

type PlayerList struct {
	sync.RWMutex
	internal map[uuid.UUID]struct{}
}

func NewPlayerList() *PlayerList {
	return &PlayerList{
		internal: make(map[uuid.UUID]struct{}),
	}
}

func (l *PlayerList) AsSlice() []uuid.UUID {
	keys := []uuid.UUID{}
	l.RLock()
	for k := range l.internal {
		keys = append(keys, k)
	}
	l.RUnlock()
	return keys
}

func (l *PlayerList) Len() int {
	l.RLock()
	length := len(l.internal)
	l.RUnlock()
	return length
}

func (l *PlayerList) Exists(key uuid.UUID) bool {
	l.RLock()
	_, ok := l.internal[key]
	l.RUnlock()
	return ok
}

func (l *PlayerList) Delete(key uuid.UUID) {
	l.Lock()
	delete(l.internal, key)
	l.Unlock()
}

func (l *PlayerList) Range(f func(k uuid.UUID)) {
	l.Lock()
	for k := range l.internal {
		f(k)
	}
	l.Unlock()
}

func (l *PlayerList) Store(key uuid.UUID) {
	l.Lock()
	l.internal[key] = struct{}{}
	l.Unlock()
}
