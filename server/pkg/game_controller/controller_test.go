package game_controller

import (
	// External

	"testing"
	"time"

	"github.com/golang/geo/s2"
	"github.com/google/uuid"
	"github.com/iakrevetkho/dots/server/pkg/player_state"
	"github.com/iakrevetkho/dots/server/pkg/zone"
	"github.com/sirupsen/logrus"
	"github.com/stretchr/testify/assert"
	"github.com/tjgq/broadcast"
	// Internal
)

func TestGameControllerStart(t *testing.T) {
	logrus.SetLevel(logrus.DebugLevel)

	timeNowMx.Lock()
	timeNow = func() time.Time { return time.Date(2000, 1, 1, 0, 0, 0, 0, time.UTC) }
	timeNowMx.Unlock()
	hunterUuid := uuid.New()

	zc := zone.NewController(s2.LatLng{Lat: 0, Lng: 0}, 200, 10, time.Second*30, time.Second*10, 10.0)
	gc := NewGameController(zc)

	assert.False(t, gc.IsActive)
	assert.Nil(t, gc.StartTime)
	assert.Nil(t, gc.HunterUuid)

	gc.Start(hunterUuid)

	assert.True(t, gc.IsActive)
	assert.NotNil(t, gc.StartTime)
	assert.Equal(t, time.Date(2000, 1, 1, 0, 0, 0, 0, time.UTC), *gc.StartTime)
	assert.NotNil(t, gc.HunterUuid)
	assert.Equal(t, hunterUuid, *gc.HunterUuid)
}

func TestGameControllerCheckNoVictims(t *testing.T) {
	logrus.SetLevel(logrus.DebugLevel)

	timeNowMx.Lock()
	timeNow = func() time.Time { return time.Date(2000, 1, 1, 0, 0, 0, 0, time.UTC) }
	timeNowMx.Unlock()
	player1Uuid := uuid.New()
	hunterUuid := player1Uuid

	zc := zone.NewController(s2.LatLng{Lat: 0, Lng: 0}, 200, 10, time.Second*30, time.Second*10, 10.0)
	gc := NewGameController(zc)

	gc.Start(hunterUuid)

	playerStateMap := player_state.NewPlayerStateMap()
	playerStateMap.Store(player1Uuid, &player_state.PlayerState{
		Position: s2.LatLng{
			Lat: 0,
			Lng: 0,
		},
		Health:      100,
		IsCaught:    false,
		Broadcaster: broadcast.New(0),
	})

	event, err := gc.Check(time.Second*10, playerStateMap)
	assert.NoError(t, err)
	assert.NotNil(t, event)
	assert.IsType(t, EndGameEvent{}, event)
	assert.Equal(t, SessionWinner_HunterWins, event.(EndGameEvent).Winner)
}

func TestGameControllerCheckNoHunters(t *testing.T) {
	logrus.SetLevel(logrus.DebugLevel)

	timeNowMx.Lock()
	timeNow = func() time.Time { return time.Date(2000, 1, 1, 0, 0, 0, 0, time.UTC) }
	timeNowMx.Unlock()
	hunterUuid := uuid.New()

	zc := zone.NewController(s2.LatLng{Lat: 0, Lng: 0}, 200, 10, time.Second*30, time.Second*10, 10.0)
	gc := NewGameController(zc)

	gc.Start(hunterUuid)

	playerStateMap := player_state.NewPlayerStateMap()

	_, err := gc.Check(time.Second*10, playerStateMap)
	assert.Error(t, err)
}

func TestGameControllerCheck(t *testing.T) {
	logrus.SetLevel(logrus.DebugLevel)

	timeNowMx.Lock()
	timeNow = func() time.Time { return time.Date(2000, 1, 1, 0, 0, 0, 0, time.UTC) }
	timeNowMx.Unlock()
	player1Uuid := uuid.New()
	player2Uuid := uuid.New()
	hunterUuid := player1Uuid

	zc := zone.NewController(s2.LatLng{Lat: 0, Lng: 0}, 200, 10, time.Second*30, time.Second*10, 10.0)
	gc := NewGameController(zc)

	gc.Start(hunterUuid)

	playerStateMap := player_state.NewPlayerStateMap()
	playerStateMap.Store(player1Uuid, &player_state.PlayerState{
		Position: s2.LatLng{
			Lat: 0,
			Lng: 0,
		},
		Health:      100,
		IsCaught:    false,
		Broadcaster: broadcast.New(0),
	})
	playerStateMap.Store(player2Uuid, &player_state.PlayerState{
		Position: s2.LatLng{
			Lat: 0.1,
			Lng: 0.1,
		},
		Health:      100,
		IsCaught:    false,
		Broadcaster: broadcast.New(0),
	})

	event, err := gc.Check(time.Second*10, playerStateMap)
	assert.NoError(t, err)
	assert.NotNil(t, event)
	assert.IsType(t, EndGameEvent{}, event)
	assert.Equal(t, SessionWinner_VictimsWins, event.(EndGameEvent).Winner)
}
