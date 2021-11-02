package player_state

import (
	// External
	"sync"

	"github.com/golang/geo/s2"
	"github.com/google/uuid"
	"github.com/tjgq/broadcast"
	// Internal
)

type PlayerState struct {
	sync.Mutex

	Position s2.LatLng
	Health   float32

	// Channel for sending state about players states
	Broadcaster *broadcast.Broadcaster
}

func NewPlayerState() *PlayerState {
	ps := new(PlayerState)

	ps.Health = 100
	ps.Broadcaster = broadcast.New(0)

	return ps
}

type PlayerPublicState struct {
	PlayerUuid uuid.UUID
	Position   s2.LatLng
	Health     float32
}
