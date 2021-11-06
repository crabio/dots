package game_controller

import (
	// External

	"testing"
	"time"

	"github.com/golang/geo/s2"
	"github.com/google/uuid"
	"github.com/iakrevetkho/dots/server/pkg/zone"
	"github.com/sirupsen/logrus"
	"github.com/stretchr/testify/assert"
	// Internal
)

func TestStart(t *testing.T) {
	logrus.SetLevel(logrus.DebugLevel)

	zc := zone.NewController(s2.LatLng{Lat: 0, Lng: 0}, 200, 10, time.Second*30, time.Second*10, 10.0)
	gc := NewGameController(zc)

	assert.False(t, gc.IsActive)
	assert.Nil(t, gc.StartTime)

	timeNowMx.Lock()
	timeNow = func() time.Time { return time.Date(2000, 1, 1, 0, 0, 0, 0, time.UTC) }
	timeNowMx.Unlock()
	hunterUuid := uuid.New()

	gc.Start(hunterUuid)

	assert.True(t, gc.IsActive)
	assert.NotNil(t, gc.StartTime)
	assert.Equal(t, time.Date(2000, 1, 1, 0, 0, 0, 0, time.UTC), *gc.StartTime)
}
