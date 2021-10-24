package spot

import (
	// External
	// Internal
	"github.com/iakrevetkho/dots/server/pkg/player_state"
)

type SpotSession struct {
	// Map with players posiiton
	//
	// key - player uuid
	// value - player state
	PlayersStateMap *player_state.PlayerStateMap
}

func NewSpotSession() *SpotSession {
	session := new(SpotSession)

	session.PlayersStateMap = player_state.NewPlayerStateMap()

	return session
}
