package api_spot_v1

import (
	// External
	"fmt"

	"github.com/google/uuid"

	// Internal
	proto "github.com/iakrevetkho/dots/server/proto/gen/spot/v1"
)

func (s *SpotServiceServer) GetSpotPlayers(request *proto.GetSpotPlayersRequest, stream proto.SpotService_GetSpotPlayersServer) error {
	s.log.WithField("request", request.String()).Trace("Get spot players list request")

	spotUuid, err := uuid.Parse(request.SpotUuid)
	if err != nil {
		return fmt.Errorf("Couldn't parse spot uuid. " + err.Error())
	}

	spot, ok := s.SpotsMap.Load(spotUuid)
	if !ok {
		return fmt.Errorf("Spot with uuid '%s' couldn't be found", spotUuid)
	}

	for playersListI := range spot.PlayersListBroadcaster.Listen().Ch {
		playersList := playersListI.([]uuid.UUID)

		response := &proto.GetSpotPlayersResponse{}
		for _, playerUuid := range playersList {
			response.PlayersList = append(response.PlayersList, playerUuid.String())
		}

		s.log.WithField("response", response.String()).Debug("Get spot players list response")
		if err := stream.Send(response); err != nil {
			return err
		}
	}
	return nil
}
