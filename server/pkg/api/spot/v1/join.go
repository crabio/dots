package api_spot_v1

import (
	// External
	"context"
	"fmt"

	"github.com/google/uuid"

	// Internal

	"github.com/iakrevetkho/dots/server/pkg/spot_session"
	proto "github.com/iakrevetkho/dots/server/proto/gen/spot/v1"
)

func (s *SpotServiceServer) JoinToSpot(ctx context.Context, request *proto.JoinToSpotRequest) (*proto.JoinToSpotResponse, error) {
	s.log.WithField("request", request.String()).Debug("Join to spot request")

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
		// Create session
		spot.Lock()
		spot.Session = spot_session.NewSpotSession(spot.Id, spot.Position, spot.RadiusInM, spot.ZonePeriod, spot.SessionDuration)
		spot.Unlock()
		s.log.Debug("Spot session created")
	}

	if spot.Session.GameController == nil {
		return nil, fmt.Errorf("GameController is not inited")
	}

	spot.Session.GameController.Lock()
	defer spot.Session.GameController.Unlock()
	if spot.Session.GameController.IsActive {
		return nil, fmt.Errorf("Can't join to active spot with uuid '%s'", spotUuid)
	}

	// Append new player
	spot.PlayersList.Store(playerUuid)

	// Send updated players list
	spot.PlayersListBroadcaster.Send(spot.PlayersList)

	// Save spot
	s.SpotsMap.Store(spotUuid, spot)

	response := proto.JoinToSpotResponse{}

	return &response, nil
}
