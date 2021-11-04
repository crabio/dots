package spot_session

import (
	// External
	"time"

	"github.com/google/uuid"

	// Internal
	"github.com/iakrevetkho/dots/server/pkg/player_state"
)

type SpotSession struct {
	// UUID of hunter player
	HunterUuid uuid.UUID

	Duration  time.Duration
	StartTime *time.Time

	// Map with players posiiton
	//
	// key - player uuid
	// value - player state
	PlayersStateMap *player_state.PlayerStateMap
}

func NewSpotSession(hunterUuid uuid.UUID, duration time.Duration, playersList []uuid.UUID) *SpotSession {
	ss := new(SpotSession)
	ss.Duration = duration
	ss.PlayersStateMap = player_state.NewPlayerStateMap()
	for _, playerUuid := range playersList {
		playerState := player_state.NewPlayerState()
		ss.PlayersStateMap.Store(playerUuid, playerState)
	}
	return ss
}

func (ss *SpotSession) Start() {
	time := time.Now().UTC()
	ss.StartTime = &time
}
