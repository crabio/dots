package api_spot_v1

import (
	// External
	"context"
	"fmt"

	"github.com/google/uuid"

	// Internal

	proto "github.com/iakrevetkho/dots/server/proto/gen/spot/v1"
)

func (s *SpotServiceServer) LeaveSpot(ctx context.Context, request *proto.LeaveSpotRequest) (*proto.LeaveSpotResponse, error) {
	s.log.WithField("request", request.String()).Debug("Leave spot request")

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

	if !spot.PlayersList.Exists(playerUuid) {
		return nil, fmt.Errorf("Player with uuid '%s' wasn't found in spot with uuid '%s'", playerUuid, spotUuid)
	}

	if spot.Session == nil {
		return nil, fmt.Errorf("Spot has no session")
	}

	if spot.Session.GameController == nil {
		return nil, fmt.Errorf("GameController is not inited")
	}

	spot.Session.GameController.Lock()
	defer spot.Session.GameController.Unlock()
	if spot.Session.GameController.IsActive {
		return nil, fmt.Errorf("Can't leave from active spot with uuid '%s'", spotUuid)
	}

	// Remove player
	spot.PlayersList.Delete(playerUuid)

	// Send updated players list
	spot.PlayersListBroadcaster.Send(spot.PlayersList)

	// Save spot
	s.SpotsMap.Store(spotUuid, spot)

	response := proto.LeaveSpotResponse{}

	return &response, nil
}
