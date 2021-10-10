package api_spot_v1_test

import (
	// External
	"context"
	"testing"

	"github.com/gofrs/uuid"
	"github.com/stretchr/testify/assert"

	// Internal
	api_spot_v1 "github.com/iakrevetkho/dots/server/pkg/api/spot/v1"
	proto "github.com/iakrevetkho/dots/server/proto/gen/spot/v1"
)

func TestCreateSpot(t *testing.T) {
	s := api_spot_v1.New()

	request := &proto.CreateSpotRequest{
		Latiitude: 11.2344,
		Longitude: -234.12244,
	}

	response, err := s.CreateSpot(context.Background(), request)
	assert.NoError(t, err)
	assert.NotEmpty(t, response.Uuid)
	_, err = uuid.FromString(response.Uuid)
	assert.NoError(t, err)
	assert.Equal(t, 11.2344, response.Latiitude)
	assert.Equal(t, -234.12244, response.Longitude)
}
