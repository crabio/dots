package api_spot_v1_test

import (
	// External
	"context"
	"testing"

	"github.com/stretchr/testify/assert"

	// Internal
	api_spot_v1 "github.com/iakrevetkho/dots/server/pkg/api/spot/v1"
	proto "github.com/iakrevetkho/dots/server/proto/gen/spot/v1"
)

func TestGetSpot(t *testing.T) {
	s := api_spot_v1.New()

	// Create spot
	createRequest := &proto.CreateSpotRequest{
		Latiitude:           11.2344,
		Longitude:           -234.12244,
		Radius:              200,
		ScanPeriodInSeconds: 30,
		ZonePeriodInSeconds: 60,
	}
	createResponse, err := s.CreateSpot(context.Background(), createRequest)
	assert.NoError(t, err)

	// Get spot
	getRequest := &proto.GetSpotRequest{
		Uuid: createResponse.Uuid,
	}

	getResponse, err := s.GetSpot(context.Background(), getRequest)
	assert.NoError(t, err)
	assert.Equal(t, getResponse.Latiitude, 11.2344)
	assert.Equal(t, getResponse.Longitude, -234.12244)
	assert.Equal(t, getResponse.Radius, int32(200))
	assert.Equal(t, getResponse.ScanPeriodInSeconds, int32(30))
	assert.Equal(t, getResponse.ZonePeriodInSeconds, int32(60))
}
