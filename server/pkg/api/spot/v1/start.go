package api_spot_v1

import (
	// External
	"context"
	"fmt"
	"math/rand"

	"github.com/google/uuid"

	// Internal

	"github.com/iakrevetkho/dots/server/pkg/utils/mock"
	proto "github.com/iakrevetkho/dots/server/proto/gen/spot/v1"
)

func (s *SpotServiceServer) StartSpot(ctx context.Context, request *proto.StartSpotRequest) (*proto.StartSpotResponse, error) {
	s.log.WithField("request", request.String()).Debug("Start spot request")

	spotUuid, err := uuid.Parse(request.SpotUuid)
	if err != nil {
		return nil, fmt.Errorf("Couldn't parse spot uuid. " + err.Error())
	}

	spot, ok := s.SpotsMap.Load(spotUuid)
	if !ok {
		return nil, fmt.Errorf("Spot with uuid '%s' couldn't be found", spotUuid)
	}

	if spot.Session == nil {
		return nil, fmt.Errorf("Spot has no session")
	}

	if spot.Session.GameController == nil {
		return nil, fmt.Errorf("GameController is not inited")
	}

	if spot.Session.GameController.IsActive {
		return nil, fmt.Errorf("Can't start active spot with uuid '%s'", spotUuid)
	}

	// Choose hunter
	mock.TimeNowMx.Lock()
	rand.Seed(mock.TimeNow().Unix())
	mock.TimeNowMx.Unlock()
	hunterUuid := spot.PlayersList[rand.Intn(len(spot.PlayersList))]

	// Start spot session
	if err := spot.Session.Start(hunterUuid, spot.PlayersList); err != nil {
		return nil, err
	}

	// Save spot on server
	s.SpotsMap.Store(spotUuid, spot)

	response := proto.StartSpotResponse{}

	return &response, nil
}
