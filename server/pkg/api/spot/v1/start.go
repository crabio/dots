package api_spot_v1

import (
	// External
	"context"
	"fmt"
	"math/rand"
	"time"

	"github.com/google/uuid"

	// Internal
	data "github.com/iakrevetkho/dots/server/pkg/spot"
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

	if spot.IsActive {
		return nil, fmt.Errorf("Can't start active spot with uuid '%s'", spotUuid)
	}

	// Make spot active
	spot.IsActive = true

	// Choose hunter
	rand.Seed(time.Now().Unix())
	hunterUuid := spot.PlayersList[rand.Intn(len(spot.PlayersList))]

	// Create spot session
	spot.Session = data.NewSpotSession(hunterUuid, spot.PlayersList)

	// Save spot on server
	s.SpotsMap.Store(spotUuid, spot)

	// Broadcast start flag
	spot.IsActiveBroadcaster.Send(true)

	response := proto.StartSpotResponse{}

	return &response, nil
}
