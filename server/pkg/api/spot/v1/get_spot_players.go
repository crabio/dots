package api_spot_v1

import (
	// External
	"fmt"

	"github.com/google/uuid"

	// Internal
	"github.com/iakrevetkho/dots/server/pkg/player_list"
	proto "github.com/iakrevetkho/dots/server/proto/gen/spot/v1"
)

func (s *SpotServiceServer) GetSpotPlayers(request *proto.GetSpotPlayersRequest, stream proto.SpotService_GetSpotPlayersServer) error {
	s.log.WithField("request", request.String()).Debug("Get spot players list request")

	spotUuid, err := uuid.Parse(request.SpotUuid)
	if err != nil {
		return fmt.Errorf("Couldn't parse spot uuid. " + err.Error())
	}

	spot, ok := s.SpotsMap.Load(spotUuid)
	if !ok {
		return fmt.Errorf("Spot with uuid '%s' couldn't be found", spotUuid)
	}

	// Send current players list
	if err := s.sendSpotPlayersList(spot.PlayersList, stream); err != nil {
		return err
	}

	for playersListI := range spot.PlayersListBroadcaster.Listen().Ch {
		if err := s.sendSpotPlayersList(playersListI.(*player_list.PlayerList), stream); err != nil {
			return err
		}
	}
	return nil
}

func (s *SpotServiceServer) sendSpotPlayersList(playersList *player_list.PlayerList, stream proto.SpotService_GetSpotPlayersServer) error {
	response := &proto.GetSpotPlayersResponse{}
	playersList.Range(func(playerUuid uuid.UUID) {
		response.PlayersList = append(response.PlayersList, playerUuid.String())
	})

	s.log.WithField("response", response.String()).Debug("Get spot players list response")
	if err := stream.Send(response); err != nil {
		return err
	}

	return nil
}
