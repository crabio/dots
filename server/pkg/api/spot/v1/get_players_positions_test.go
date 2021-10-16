package api_spot_v1_test

import (
	// External
	"context"
	"sync"
	"testing"

	"github.com/google/uuid"
	"github.com/stretchr/testify/assert"
	"google.golang.org/grpc"

	// Internal
	api_spot_v1 "github.com/iakrevetkho/dots/server/pkg/api/spot/v1"
	proto "github.com/iakrevetkho/dots/server/proto/gen/spot/v1"
)

type MockGetPlayerPositionServer struct {
	SpotUuid             uuid.UUID
	PlayerUuid           uuid.UUID
	MsgCount             uint32
	LastPlayersPositions *proto.GetPlayersPositionsResponse
	sync.Mutex
	grpc.ServerStream
}

func (s *MockGetPlayerPositionServer) Send(response *proto.GetPlayersPositionsResponse) error {
	print(s.MsgCount)
	if s.MsgCount > 0 {
		s.Lock()
		s.MsgCount -= 1
		s.Unlock()
		return nil
	} else {
		s.LastPlayersPositions = response
		return grpc.ErrClientConnClosing
	}
}

func TestGetPlayerPosition(t *testing.T) {
	s := api_spot_v1.New()

	// Create spot first
	createSpotRet, err := s.CreateSpot(context.Background(), &proto.CreateSpotRequest{
		Position: &proto.Position{
			Latitude:  10,
			Longitude: 20,
		},
		Radius:              100,
		ScanPeriodInSeconds: 10,
		ZonePeriodInSeconds: 30,
	})
	assert.NoError(t, err)

	spotUuid := uuid.MustParse(createSpotRet.SpotUuid)
	playerUuid := uuid.New()
	player2Uuid := uuid.New()
	player3Uuid := uuid.New()

	// Add positions
	spot := s.SpotsMap[spotUuid]
	s.SpotsMap[spotUuid] = api_spot_v1.Spot{
		Position:   spot.Position,
		Radius:     spot.Radius,
		ScanPeriod: spot.ScanPeriod,
		ZonePeriod: spot.ZonePeriod,
		PlayersPositionsMap: map[uuid.UUID]api_spot_v1.Position{
			playerUuid: api_spot_v1.Position{
				Latitude:  10,
				Longitude: 20,
			},
			player2Uuid: api_spot_v1.Position{
				Latitude:  60,
				Longitude: 70,
			},
			player3Uuid: api_spot_v1.Position{
				Latitude:  80,
				Longitude: 90,
			},
		},
	}

	// Create stream for getting position
	mockServer := MockGetPlayerPositionServer{
		SpotUuid:   spotUuid,
		PlayerUuid: playerUuid,
		MsgCount:   2,
	}
	request := &proto.GetPlayersPositionsRequest{
		SpotUuid:   spotUuid.String(),
		PlayerUuid: playerUuid.String(),
	}
	err = s.GetPlayersPositions(request, &mockServer)
	assert.Error(t, err)

	assert.Equal(t, uint32(0), mockServer.MsgCount)
	assert.NotNil(t, mockServer.LastPlayersPositions)
	assert.Equal(t, float64(10), mockServer.LastPlayersPositions.PlayerPosition.Latitude)
	assert.Equal(t, float64(20), mockServer.LastPlayersPositions.PlayerPosition.Longitude)

	assert.Equal(t, 2, len(mockServer.LastPlayersPositions.OtherPlayersPositions))
	assert.Equal(t, player2Uuid.String(), mockServer.LastPlayersPositions.OtherPlayersPositions[0].PlayerUuid)
	assert.Equal(t, float64(60), mockServer.LastPlayersPositions.OtherPlayersPositions[0].Position.Latitude)
	assert.Equal(t, float64(70), mockServer.LastPlayersPositions.OtherPlayersPositions[0].Position.Longitude)
	assert.Equal(t, player3Uuid.String(), mockServer.LastPlayersPositions.OtherPlayersPositions[1].PlayerUuid)
	assert.Equal(t, float64(80), mockServer.LastPlayersPositions.OtherPlayersPositions[1].Position.Latitude)
	assert.Equal(t, float64(90), mockServer.LastPlayersPositions.OtherPlayersPositions[1].Position.Longitude)
}
