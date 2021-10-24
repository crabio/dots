package api_spot_v1_test

import (
	// External
	"context"
	"testing"
	"time"

	"github.com/google/uuid"
	"github.com/stretchr/testify/assert"

	// Internal
	api_spot_v1 "github.com/iakrevetkho/dots/server/pkg/api/spot/v1"
	proto "github.com/iakrevetkho/dots/server/proto/gen/spot/v1"
)

func TestCreateSpot(t *testing.T) {
	s := api_spot_v1.New(100 * time.Millisecond)

	request := &proto.CreateSpotRequest{
		Position: &proto.Position{
			Latitude:  11.2344,
			Longitude: -234.12244,
		},
		Radius:              200,
		ScanPeriodInSeconds: 30,
		ZonePeriodInSeconds: 60,
	}

	response, err := s.CreateSpot(context.Background(), request)
	assert.NoError(t, err)
	assert.NotEmpty(t, response.SpotUuid)
	spotUuid, err := uuid.Parse(response.SpotUuid)
	assert.NoError(t, err)

	v, ok := s.SpotsMap.Load(spotUuid)
	spot := v.(api_spot_v1.Spot)

	assert.True(t, ok)
	assert.Equal(t, 11.2344, spot.Position.Lat.Degrees())
	assert.Equal(t, -234.12244, spot.Position.Lng.Degrees())
	assert.Equal(t, int32(200), spot.ZoneRadius)
	assert.Equal(t, float64(30), spot.ScanPeriod.Seconds())
	assert.Equal(t, float64(60), spot.ZonePeriod.Seconds())
}
