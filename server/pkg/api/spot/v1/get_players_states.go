package api_spot_v1

import (
	// External

	"fmt"

	"github.com/google/uuid"

	// Internal
	"github.com/iakrevetkho/dots/server/pkg/player_state"
	proto "github.com/iakrevetkho/dots/server/proto/gen/spot/v1"
)

func (s *SpotServiceServer) GetPlayersStates(request *proto.GetPlayersStatesRequest, stream proto.SpotService_GetPlayersStatesServer) error {
	s.log.WithField("request", request.String()).Trace("Get players positions")

	spotUuid, err := uuid.Parse(request.SpotUuid)
	if err != nil {
		return fmt.Errorf("Couldn't parse spot uuid. " + err.Error())
	}

	spot, ok := s.SpotsMap.Load(spotUuid)
	if !ok {
		return fmt.Errorf("Spot with uuid '%s' couldn't be found", spotUuid)
	}

	playerUuid, err := uuid.Parse(request.PlayerUuid)
	if err != nil {
		return fmt.Errorf("Couldn't parse user uuid. " + err.Error())
	}

	if spot.Session == nil {
		return fmt.Errorf("Spot has no active session")
	}

	playerState, ok := spot.Session.PlayersStateMap.Load(playerUuid)
	if !ok {
		return fmt.Errorf("Player with uuid '%s' couldn't be found in spot '%s'", playerUuid, spotUuid)
	}

	// Check that player hadn't subscription
	if playerState.Sub != nil {
		return fmt.Errorf("User %v already has subscription", playerUuid)
	}

	playerSub := make(chan player_state.PlayerPublicState)
	playerState.Sub = &playerSub
	// Update player state
	spot.Session.PlayersStateMap.Store(playerUuid, playerState)
	s.SpotsMap.Store(spotUuid, spot)

	for playerState := range playerSub {
		response := &proto.GetPlayersStatesResponse{
			PlayerState: &proto.PlayerState{
				PlayerUuid: playerState.PlayerUuid.String(),
				Position: &proto.Position{
					Latitude:  playerState.Position.Lat.Degrees(),
					Longitude: playerState.Position.Lng.Degrees(),
				},
				Health: int32(playerState.Health),
			},
		}

		s.log.WithField("response", response.String()).Debug("Get players state response")
		if err := stream.Send(response); err != nil {
			// Remove channel from current state
			close(playerSub)

			spot, ok := s.SpotsMap.Load(spotUuid)
			if !ok {
				return fmt.Errorf("Spot with uuid '%s' couldn't be found", spotUuid)
			}

			playerState, ok := spot.Session.PlayersStateMap.Load(playerUuid)
			if !ok {
				return fmt.Errorf("Player with uuid '%s' couldn't be found in spot '%s'", playerUuid, spotUuid)
			}

			playerState.Sub = nil

			// Update player state
			spot.Session.PlayersStateMap.Store(playerUuid, playerState)
			s.SpotsMap.Store(spotUuid, spot)

			return err
		}
	}
	return nil
}
