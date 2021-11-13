package api_spot_v1_test

import (
	// External

	"context"
	"io"
	"sync"
	"testing"
	"time"

	"github.com/google/uuid"
	"github.com/sirupsen/logrus"
	"github.com/stretchr/testify/assert"
	"google.golang.org/grpc"

	// Internal
	api_spot_v1 "github.com/iakrevetkho/dots/server/pkg/api/spot/v1"
	"github.com/iakrevetkho/dots/server/pkg/utils/mock"
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
	player1Uuid := uuid.New()
	player2Uuid := uuid.New()

	// Join hunter to spot
	_, err = s.JoinToSpot(context.Background(), &proto.JoinToSpotRequest{
		SpotUuid:   spotUuid.String(),
		PlayerUuid: player1Uuid.String(),
	})
	assert.NoError(t, err)
	// Join victim to spot
	// NOTE. We should have at least hunter and victim for the game
	_, err = s.JoinToSpot(context.Background(), &proto.JoinToSpotRequest{
		SpotUuid:   spotUuid.String(),
		PlayerUuid: player2Uuid.String(),
	})
	assert.NoError(t, err)

	// Start spot
	_, err = s.StartSpot(context.Background(), &proto.StartSpotRequest{
		SpotUuid: spotUuid.String(),
	})
	assert.NoError(t, err)

	// Create stream for sending position
	mockServer := MockSendPlayerPositionServer{
		SpotUuid:   spotUuid,
		PlayerUuid: player1Uuid,
		MsgCount:   5,
	}

	assert.NoError(t, s.SendPlayerPosition(&mockServer))

	assert.Equal(t, uint32(0), mockServer.MsgCount)
	assert.True(t, mockServer.Closed)

	spot, ok := s.SpotsMap.Load(spotUuid)
	assert.True(t, ok)

	playerState, ok := spot.Session.PlayersStateMap.Load(player1Uuid)
	assert.True(t, ok)

	assert.Equal(t, float64(10), playerState.Position.Lat.Degrees())
	assert.Equal(t, float64(20), playerState.Position.Lng.Degrees())
	assert.Equal(t, float32(100), playerState.Health)
}
