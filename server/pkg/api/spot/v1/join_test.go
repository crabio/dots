package api_spot_v1_test

import (
	// External

	"context"
	"testing"
	"time"

	"github.com/google/uuid"
	"github.com/sirupsen/logrus"
	"github.com/stretchr/testify/assert"

	// Internal
	api_spot_v1 "github.com/iakrevetkho/dots/server/pkg/api/spot/v1"
	"github.com/iakrevetkho/dots/server/pkg/utils/mock"
	proto "github.com/iakrevetkho/dots/server/proto/gen/spot/v1"
)

func TestJoinSpot(t *testing.T) {
	mock.TimeNowMx.Lock()
	mock.TimeNow = func() time.Time { return time.Date(2000, 1, 1, 0, 0, 0, 0, time.UTC) }
	mock.TimeNowMx.Unlock()
	logrus.SetLevel(logrus.DebugLevel)

	s := api_spot_v1.New(100 * time.Millisecond)

	// Create spot first
	createSpotRet, err := s.CreateSpot(context.Background(), &proto.CreateSpotRequest{
		Position: &proto.Position{
			Latitude:  10,
			Longitude: 20,
		},
		RadiusInM:           100,
		ScanPeriodInSeconds: 10,
		ZonePeriodInSeconds: 30,
	})
	assert.NoError(t, err)

	spotUuid := uuid.MustParse(createSpotRet.SpotUuid)
	playerUuid := uuid.New()

	// Check that we have no active spot session
	spot, ok := s.SpotsMap.Load(spotUuid)
	assert.True(t, ok)
	assert.Nil(t, spot.Session)

	// Join player to spot
	_, err = s.JoinToSpot(context.Background(), &proto.JoinToSpotRequest{
		SpotUuid:   spotUuid.String(),
		PlayerUuid: playerUuid.String(),
	})
	assert.NoError(t, err)

	// Check that we have active spot session
	spot, ok = s.SpotsMap.Load(spotUuid)
	assert.True(t, ok)
	assert.NotNil(t, spot.Session)
}
