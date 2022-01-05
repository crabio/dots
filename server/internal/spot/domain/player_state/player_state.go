package player_state

import (
	"github.com/golang/geo/s2"
	"github.com/tjgq/broadcast"
)

type PlayerState struct {
	Position s2.LatLng
	Health   float32
	// Flag shows status of non-hunter player
	// Will be true, if player was caught by hunter
	IsCaught bool

	// Channel for sending state about players states
	Broadcaster *broadcast.Broadcaster
}

func NewPlayerState() *PlayerState {
	ps := new(PlayerState)

	ps.Health = 100
	ps.Broadcaster = broadcast.New(0)

	return ps
}
