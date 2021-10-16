package api_spot_v1

import (
	// External

	"fmt"
	"time"

	"github.com/google/uuid"

	// Internal
	proto "github.com/iakrevetkho/dots/server/proto/gen/spot/v1"
)

func (s *SpotServiceServer) GetPlayersStates(request *proto.GetPlayersStatesRequest, stream proto.SpotService_GetPlayersStatesServer) error {
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

		thisPlayerState := spot.PlayersStateMap[playerUuid]

		otherPlayersStates := []*proto.PlayerState{}
		for k, v := range spot.PlayersStateMap {
			if k != playerUuid {
				otherPlayersStates = append(otherPlayersStates, &proto.PlayerState{
					PlayerUuid: k.String(),
					Position: &proto.Position{
						Latitude:  v.Position.Latitude,
						Longitude: v.Position.Longitude,
					},
					Health: int32(v.Health),
				})
			}
		}
		// TODO Remove adding fake positions
		// for i := 0; i < 10; i++ {
		// 	otherPlayersStates = append(otherPlayersStates, &proto.PlayerState{
		// 		PlayerUuid: uuid.NewString(),
		// 		Position: &proto.Position{
		// 			Latitude:  thisPlayerState.Position.Latitude + (rand.Float64()*0.004 - 0.002),
		// 			Longitude: thisPlayerState.Position.Longitude + (rand.Float64()*0.004 - 0.002),
		// 		},
		// 		Health: int32(rand.Float64() * 100),
		// 	})
		// }

		response := &proto.GetPlayersStatesResponse{
			PlayerState: &proto.PlayerState{
				Position: &proto.Position{
					Latitude:  thisPlayerState.Position.Latitude,
					Longitude: thisPlayerState.Position.Longitude,
				},
				Health: int32(thisPlayerState.Health),
			},
			OtherPlayersStates: otherPlayersStates,
		}

		s.log.WithField("response", response.String()).Trace("Get spot response")
		if err := stream.Send(response); err != nil {
			ticker.Stop()
			return err
		}
	}
	return nil
}
