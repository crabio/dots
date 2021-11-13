package game_controller

import (
	// External

	"testing"
	"time"

	"github.com/golang/geo/s2"
	"github.com/google/uuid"
	"github.com/iakrevetkho/dots/server/pkg/player_state"
	"github.com/iakrevetkho/dots/server/pkg/utils/mock"
	"github.com/sirupsen/logrus"
	"github.com/stretchr/testify/assert"
	"github.com/tjgq/broadcast"
	// Internal
)

func TestGameControllerStart(t *testing.T) {
	logrus.SetLevel(logrus.DebugLevel)

	mock.TimeNowMx.Lock()
	mock.TimeNow = func() time.Time { return time.Date(2000, 1, 1, 0, 0, 0, 0, time.UTC) }
	mock.TimeNowMx.Unlock()
	hunterUuid := uuid.New()

	gc := NewGameController(time.Second)

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

	mock.TimeNowMx.Lock()
	mock.TimeNow = func() time.Time { return time.Date(2000, 1, 1, 0, 0, 0, 0, time.UTC) }
	mock.TimeNowMx.Unlock()
	hunterUuid := uuid.New()

	gc := NewGameController(time.Second * 10)

	gc.Start(hunterUuid)

	playerStateMap := player_state.NewPlayerStateMap()
	playerStateMap.Store(hunterUuid, &player_state.PlayerState{
		Position: s2.LatLng{
			Lat: 0,
			Lng: 0,
		},
		Health:      100,
		IsCaught:    false,
		Broadcaster: broadcast.New(0),
	})

	event, err := gc.Check(playerStateMap)
	assert.NoError(t, err)
	assert.NotNil(t, event)
	assert.Equal(t, EndGameEvent{Winner: SessionWinner_HunterWins}, *event)
}

func TestGameControllerCheckNoHunters(t *testing.T) {
	logrus.SetLevel(logrus.DebugLevel)

	mock.TimeNowMx.Lock()
	mock.TimeNow = func() time.Time { return time.Date(2000, 1, 1, 0, 0, 0, 0, time.UTC) }
	mock.TimeNowMx.Unlock()
	hunterUuid := uuid.New()

	gc := NewGameController(time.Second * 10)

	gc.Start(hunterUuid)

	playerStateMap := player_state.NewPlayerStateMap()

	_, err := gc.Check(playerStateMap)
	assert.Error(t, err)
}

func TestGameControllerNoEvent(t *testing.T) {
	logrus.SetLevel(logrus.DebugLevel)

	mock.TimeNowMx.Lock()
	mock.TimeNow = func() time.Time { return time.Date(2000, 1, 1, 0, 0, 0, 0, time.UTC) }
	mock.TimeNowMx.Unlock()
	player1Uuid := uuid.New()
	hunterUuid := uuid.New()

	gc := NewGameController(time.Second * 10)

	gc.Start(hunterUuid)

	playerStateMap := player_state.NewPlayerStateMap()
	playerStateMap.Store(player1Uuid, &player_state.PlayerState{
		Position: s2.LatLng{
			Lat: 0.1,
			Lng: 0.1,
		},
		Health:      100,
		IsCaught:    false,
		Broadcaster: broadcast.New(0),
	})
	playerStateMap.Store(hunterUuid, &player_state.PlayerState{
		Position: s2.LatLng{
			Lat: 0.1,
			Lng: 0.1,
		},
		Health:      100,
		IsCaught:    false,
		Broadcaster: broadcast.New(0),
	})

	event, err := gc.Check(playerStateMap)
	assert.NoError(t, err)
	assert.Nil(t, event)
}

func TestGameControllerCheckTimeOut(t *testing.T) {
	logrus.SetLevel(logrus.DebugLevel)

	mock.TimeNowMx.Lock()
	mock.TimeNow = func() time.Time { return time.Date(2000, 1, 1, 0, 0, 0, 0, time.UTC) }
	mock.TimeNowMx.Unlock()
	player1Uuid := uuid.New()
	player2Uuid := uuid.New()
	hunterUuid := uuid.New()

	gc := NewGameController(time.Second * 10)

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
	playerStateMap.Store(hunterUuid, &player_state.PlayerState{
		Position: s2.LatLng{
			Lat: 0.1,
			Lng: 0.1,
		},
		Health:      100,
		IsCaught:    false,
		Broadcaster: broadcast.New(0),
	})

	mock.TimeNowMx.Lock()
	mock.TimeNow = func() time.Time { return time.Date(2000, 1, 1, 0, 0, 11, 0, time.UTC) }
	mock.TimeNowMx.Unlock()

	event, err := gc.Check(playerStateMap)
	assert.NoError(t, err)
	assert.NotNil(t, event)
	assert.Equal(t, EndGameEvent{Winner: SessionWinner_VictimsWins}, *event)
}

func TestGameControllerVictimsCaughtOrDead(t *testing.T) {
	logrus.SetLevel(logrus.DebugLevel)

	mock.TimeNowMx.Lock()
	mock.TimeNow = func() time.Time { return time.Date(2000, 1, 1, 0, 0, 0, 0, time.UTC) }
	mock.TimeNowMx.Unlock()
	player1Uuid := uuid.New()
	hunterUuid := uuid.New()

	gc := NewGameController(time.Second * 10)

	gc.Start(hunterUuid)

	playerStateMap := player_state.NewPlayerStateMap()
	playerStateMap.Store(hunterUuid, &player_state.PlayerState{
		Position: s2.LatLng{
			Lat: 0,
			Lng: 0,
		},
		Health:      100,
		IsCaught:    true,
		Broadcaster: broadcast.New(0),
	})
	playerStateMap.Store(player1Uuid, &player_state.PlayerState{
		Position: s2.LatLng{
			Lat: 0.1,
			Lng: 0.1,
		},
		Health:      0,
		IsCaught:    false,
		Broadcaster: broadcast.New(0),
	})

	mock.TimeNowMx.Lock()
	mock.TimeNow = func() time.Time { return time.Date(2000, 1, 1, 0, 0, 11, 0, time.UTC) }
	mock.TimeNowMx.Unlock()

	event, err := gc.Check(playerStateMap)
	assert.NoError(t, err)
	assert.NotNil(t, event)
	assert.Equal(t, EndGameEvent{Winner: SessionWinner_HunterWins}, *event)
}

func TestGameControllerHunterDead(t *testing.T) {
	logrus.SetLevel(logrus.DebugLevel)

	mock.TimeNowMx.Lock()
	mock.TimeNow = func() time.Time { return time.Date(2000, 1, 1, 0, 0, 0, 0, time.UTC) }
	mock.TimeNowMx.Unlock()
	player1Uuid := uuid.New()
	hunterUuid := uuid.New()

	gc := NewGameController(time.Second * 10)

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
	playerStateMap.Store(hunterUuid, &player_state.PlayerState{
		Position: s2.LatLng{
			Lat: 0.1,
			Lng: 0.1,
		},
		Health:      0,
		IsCaught:    false,
		Broadcaster: broadcast.New(0),
	})

	mock.TimeNowMx.Lock()
	mock.TimeNow = func() time.Time { return time.Date(2000, 1, 1, 0, 0, 11, 0, time.UTC) }
	mock.TimeNowMx.Unlock()

	event, err := gc.Check(playerStateMap)
	assert.NoError(t, err)
	assert.NotNil(t, event)
	assert.Equal(t, EndGameEvent{Winner: SessionWinner_VictimsWins}, *event)
}

func TestGameControllerAllDead(t *testing.T) {
	logrus.SetLevel(logrus.DebugLevel)

	mock.TimeNowMx.Lock()
	mock.TimeNow = func() time.Time { return time.Date(2000, 1, 1, 0, 0, 0, 0, time.UTC) }
	mock.TimeNowMx.Unlock()
	player1Uuid := uuid.New()
	hunterUuid := uuid.New()

	gc := NewGameController(time.Second * 10)

	gc.Start(hunterUuid)

	playerStateMap := player_state.NewPlayerStateMap()
	playerStateMap.Store(player1Uuid, &player_state.PlayerState{
		Position: s2.LatLng{
			Lat: 0,
			Lng: 0,
		},
		Health:      0,
		IsCaught:    false,
		Broadcaster: broadcast.New(0),
	})
	playerStateMap.Store(hunterUuid, &player_state.PlayerState{
		Position: s2.LatLng{
			Lat: 0.1,
			Lng: 0.1,
		},
		Health:      0,
		IsCaught:    false,
		Broadcaster: broadcast.New(0),
	})

	mock.TimeNowMx.Lock()
	mock.TimeNow = func() time.Time { return time.Date(2000, 1, 1, 0, 0, 11, 0, time.UTC) }
	mock.TimeNowMx.Unlock()

	event, err := gc.Check(playerStateMap)
	assert.NoError(t, err)
	assert.NotNil(t, event)
	assert.Equal(t, EndGameEvent{Winner: SessionWinner_Draw}, *event)
}
