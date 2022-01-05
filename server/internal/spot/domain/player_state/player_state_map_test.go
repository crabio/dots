package player_state_test

import (
	"testing"

	"github.com/golang/geo/s2"
	"github.com/google/uuid"
	"github.com/iakrevetkho/dots/server/internal/domain/player_state"
	"github.com/stretchr/testify/assert"
)

func TestPlayerStateMap(t *testing.T) {
	player1Uuid := uuid.New()
	player2Uuid := uuid.New()
	player3Uuid := uuid.New()

	psm := player_state.NewPlayerStateMap()

	psm.Store(player1Uuid, player_state.NewPlayerState())
	psm.Store(player2Uuid, player_state.NewPlayerState())
	psm.Store(player3Uuid, player_state.NewPlayerState())

	ps1, ok := psm.Load(player1Uuid)
	assert.True(t, ok)
	assert.Equal(t, s2.LatLng{Lat: 0, Lng: 0}, ps1.Position)
	assert.Equal(t, float32(100), ps1.Health)
	assert.NotNil(t, ps1.Broadcaster)

	ps2, ok := psm.Load(player2Uuid)
	assert.True(t, ok)
	assert.Equal(t, s2.LatLng{Lat: 0, Lng: 0}, ps2.Position)
	assert.Equal(t, float32(100), ps2.Health)
	assert.NotNil(t, ps2.Broadcaster)

	ps3, ok := psm.Load(player3Uuid)
	assert.True(t, ok)
	assert.Equal(t, s2.LatLng{Lat: 0, Lng: 0}, ps3.Position)
	assert.Equal(t, float32(100), ps3.Health)
	assert.NotNil(t, ps3.Broadcaster)

	i := 0
	psm.Range(func(k uuid.UUID, v *player_state.PlayerState) {
		i++
	})
	assert.Equal(t, 3, i)

	psm.Delete(player2Uuid)

	i = 0
	psm.Range(func(k uuid.UUID, v *player_state.PlayerState) {
		i++
	})
	assert.Equal(t, 2, i)
}
