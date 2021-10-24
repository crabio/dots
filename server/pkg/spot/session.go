package spot

import (
	// External
	"github.com/google/uuid"

	// Internal
	"github.com/iakrevetkho/dots/server/pkg/player_state"
)

type SpotSession struct {
	// UUID of hunter player
	HunterUuid uuid.UUID

	// Map with players posiiton
	//
	// key - player uuid
	// value - player state
	PlayersStateMap *player_state.PlayerStateMap
}

func NewSpotSession(hunterUuid uuid.UUID, playersList []uuid.UUID) *SpotSession {
	session := new(SpotSession)

	session.PlayersStateMap = player_state.NewPlayerStateMap()
	for _, playerUuid := range playersList {
		session.PlayersStateMap.Store(playerUuid, player_state.PlayerState{
			Health: 100,
		})
	}

	return session
}
