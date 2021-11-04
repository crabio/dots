package api_spot_v1

import (
	// External
	"context"
	"fmt"

	"github.com/google/uuid"

	// Internal

	proto "github.com/iakrevetkho/dots/server/proto/gen/spot/v1"
)

func (s *SpotServiceServer) IsPlayerHunter(ctx context.Context, request *proto.IsPlayerHunterRequest) (*proto.IsPlayerHunterResponse, error) {
	s.log.WithField("request", request.String()).Debug("Is player hunter request")

	spotUuid, err := uuid.Parse(request.SpotUuid)
	if err != nil {
		return nil, fmt.Errorf("Couldn't parse spot uuid. " + err.Error())
	}

	playerUuid, err := uuid.Parse(request.PlayerUuid)
	if err != nil {
		return nil, fmt.Errorf("Couldn't parse player uuid. " + err.Error())
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

	spot.Session.GameController.Lock()
	if !spot.Session.GameController.IsActive {
		spot.Session.GameController.Unlock()
		return nil, fmt.Errorf("Spot is not active")
	}

	response := proto.IsPlayerHunterResponse{
		IsHunter: *spot.Session.GameController.HunterUuid == playerUuid,
	}
	spot.Session.GameController.Unlock()

	s.log.WithField("response", response.String()).Debug("Is player hunter response")

	return &response, nil
}
