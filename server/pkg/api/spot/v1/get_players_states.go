package api_spot_v1

import (
	// External

	"errors"
	"fmt"

	"github.com/google/uuid"

	// Internal
	"github.com/iakrevetkho/dots/server/pkg/player_state"
	proto "github.com/iakrevetkho/dots/server/proto/gen/spot/v1"
)

func (s *SpotServiceServer) GetPlayersStates(request *proto.GetPlayersStatesRequest, stream proto.SpotService_GetPlayersStatesServer) error {
	s.log.WithField("request", request.String()).Debug("Get players positions")

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

	// Update player state
	if err := spot.Session.NewPlayersState(playerUuid, playerState); err != nil {
		return err
	}
	s.SpotsMap.Store(spotUuid, spot)

	// Check that broadcaster is exists
	if playerState.Broadcaster == nil {
		return errors.New("Player states broadcaster was closed")
	}

	for playerStateI := range playerState.Broadcaster.Listen().Ch {
		playerState := playerStateI.(player_state.PlayerPublicState)

		response := &proto.GetPlayersStatesResponse{
			PlayerState: &proto.PlayerState{
				PlayerUuid: playerState.PlayerUuid.String(),
				Position: &proto.Position{
					Latitude:  playerState.Position.Lat.Degrees(),
					Longitude: playerState.Position.Lng.Degrees(),
				},
				Health: playerState.Health,
			},
		}

		s.log.WithField("response", response.String()).Trace("Get players state response")
		if err := stream.Send(response); err != nil {
			return err
		}
	}
	return nil
}
