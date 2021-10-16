package api_spot_v1_test

import (
	// External
	"context"
	"testing"
	"time"

	"github.com/stretchr/testify/assert"

	// Internal
	api_spot_v1 "github.com/iakrevetkho/dots/server/pkg/api/spot/v1"
	proto "github.com/iakrevetkho/dots/server/proto/gen/spot/v1"
)

func TestGetSpot(t *testing.T) {
	s := api_spot_v1.New(100 * time.Millisecond)

	// Create spot
	createRequest := &proto.CreateSpotRequest{
		Position: &proto.Position{
			Latitude:  11.2344,
			Longitude: -234.12244,
		},
		Radius:              200,
		ScanPeriodInSeconds: 30,
		ZonePeriodInSeconds: 60,
	}
	createResponse, err := s.CreateSpot(context.Background(), createRequest)
	assert.NoError(t, err)

	// Get spot
	getRequest := &proto.GetSpotRequest{
		SpotUuid: createResponse.SpotUuid,
	}

	getResponse, err := s.GetSpot(context.Background(), getRequest)
	assert.NoError(t, err)
	assert.Equal(t, 11.2344, getResponse.Position.Latitude)
	assert.Equal(t, -234.12244, getResponse.Position.Longitude)
	assert.Equal(t, int32(200), getResponse.Radius)
	assert.Equal(t, int32(30), getResponse.ScanPeriodInSeconds)
	assert.Equal(t, int32(60), getResponse.ZonePeriodInSeconds)
}
