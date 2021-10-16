package api_spot_v1

import (
	// External

	"fmt"
	"math/rand"
	"time"

	"github.com/google/uuid"

	// Internal
	proto "github.com/iakrevetkho/dots/server/proto/gen/spot/v1"
)

func (s *SpotServiceServer) GetPlayersPositions(request *proto.GetPlayersPositionsRequest, stream proto.SpotService_GetPlayersPositionsServer) error {
	s.log.WithField("request", request.String()).Trace("Get players positions")

	spotUuid, err := uuid.Parse(request.SpotUuid)
	if err != nil {
		return fmt.Errorf("Couldn't parse spot uuid. " + err.Error())
	}

	playerUuid, err := uuid.Parse(request.PlayerUuid)
	if err != nil {
		return fmt.Errorf("Couldn't parse user uuid. " + err.Error())
	}

	// Create ticker for sending data updates
	// TODO Use channels instead timers. Create channel to send position update to specific user
	ticker := time.NewTicker(s.playersPosUpdatePeriod)

	// For each ticker tick
	for _ = range ticker.C {
		spot, ok := s.SpotsMap[spotUuid]
		if !ok {
			ticker.Stop()
			return fmt.Errorf("Spot with uuid '%s' couldn't be found", spotUuid)
		}

		thisPlayerPosition := spot.PlayersPositionsMap[playerUuid]

		otherPlayersPositions := []*proto.PlayerPosition{}
		for k, v := range spot.PlayersPositionsMap {
			if k != playerUuid {
				otherPlayersPositions = append(otherPlayersPositions, &proto.PlayerPosition{
					PlayerUuid: k.String(),
					Position: &proto.Position{
						Latitude:  v.Latitude,
						Longitude: v.Longitude,
					},
				})
			}
		}
		// TODO Remove adding fake positions
		for i := 0; i < 10; i++ {
			otherPlayersPositions = append(otherPlayersPositions, &proto.PlayerPosition{
				PlayerUuid: uuid.NewString(),
				Position: &proto.Position{
					Latitude:  thisPlayerPosition.Latitude + (rand.Float64()*0.004 - 0.002),
					Longitude: thisPlayerPosition.Longitude + (rand.Float64()*0.004 - 0.002),
				},
			})
		}

		response := &proto.GetPlayersPositionsResponse{
			PlayerPosition: &proto.Position{
				Latitude:  thisPlayerPosition.Latitude,
				Longitude: thisPlayerPosition.Longitude,
			},
			OtherPlayersPositions: otherPlayersPositions,
		}

		s.log.WithField("response", response.String()).Trace("Get spot response")
		if err := stream.Send(response); err != nil {
			ticker.Stop()
			return err
		}
	}
	return nil
}
