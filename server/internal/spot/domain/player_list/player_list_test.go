package player_list_test

import (
	"testing"

	"github.com/google/uuid"
	"github.com/iakrevetkho/dots/server/internal/domain/player_list"
	"github.com/stretchr/testify/assert"
)

func TestPlayerList(t *testing.T) {
	player1Uuid := uuid.New()
	player2Uuid := uuid.New()
	player3Uuid := uuid.New()

	pl := player_list.NewPlayerList()

	pl.Store(player1Uuid)
	pl.Store(player2Uuid)
	pl.Store(player3Uuid)

	assert.True(t, pl.Exists(player1Uuid))
	assert.True(t, pl.Exists(player2Uuid))
	assert.True(t, pl.Exists(player3Uuid))

	plSlice := pl.AsSlice()

	assert.Equal(t, 3, len(plSlice))

	assert.Equal(t, 3, pl.Len())

	pl.Delete(player2Uuid)

	assert.True(t, pl.Exists(player1Uuid))
	assert.False(t, pl.Exists(player2Uuid))
	assert.True(t, pl.Exists(player3Uuid))

	i := 0
	pl.Range(func(k uuid.UUID) {
		i++
	})
	assert.Equal(t, 2, i)
}
