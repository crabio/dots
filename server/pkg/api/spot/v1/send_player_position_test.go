package api_spot_v1_test

import (
	// External

	"context"
	"io"
	"sync"
	"testing"

	"github.com/google/uuid"
	"github.com/stretchr/testify/assert"
	"google.golang.org/grpc"

	// Internal
	api_spot_v1 "github.com/iakrevetkho/dots/server/pkg/api/spot/v1"
	proto "github.com/iakrevetkho/dots/server/proto/gen/spot/v1"
)

type MockSendPlayerPositionServer struct {
	SpotUuid   uuid.UUID
	PlayerUuid uuid.UUID
	MsgCount   uint32
	Closed     bool
	sync.Mutex
	grpc.ServerStream
}

func (s *MockSendPlayerPositionServer) Recv() (*proto.SendPlayerPositionRequest, error) {
	if s.MsgCount > 0 {
		s.Lock()
		s.MsgCount -= 1
		s.Unlock()
		return &proto.SendPlayerPositionRequest{
			SpotUuid:   s.SpotUuid.String(),
			PlayerUuid: s.PlayerUuid.String(),
			Position: &proto.Position{
				Latitude:  10,
				Longitude: 20,
			},
		}, nil
	} else {
		return nil, io.EOF
	}
}

func (s *MockSendPlayerPositionServer) SendAndClose(*proto.SendPlayerPositionResponse) error {
	s.Lock()
	s.Closed = true
	s.Unlock()
	return nil
}

func TestSendPlayerPosition(t *testing.T) {
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

	// Create stream for sending position
	mockServer := MockSendPlayerPositionServer{
		SpotUuid:   spotUuid,
		PlayerUuid: playerUuid,
		MsgCount:   5,
	}

	assert.NoError(t, s.SendPlayerPosition(&mockServer))

	assert.Equal(t, uint32(0), mockServer.MsgCount)
	assert.True(t, mockServer.Closed)

	spot := s.SpotsMap[spotUuid]
	playerPosition := spot.PlayersPositionsMap[playerUuid]
	assert.Equal(t, float64(10), playerPosition.Latitude)
	assert.Equal(t, float64(20), playerPosition.Longitude)
}
