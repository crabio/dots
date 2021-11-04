package api_spot_v1

import (
	"errors"
	"fmt"

	"github.com/google/uuid"
	api_spot_v1_utils "github.com/iakrevetkho/dots/server/pkg/api/spot/v1/utils"
	"github.com/iakrevetkho/dots/server/pkg/game_controller"
	proto "github.com/iakrevetkho/dots/server/proto/gen/spot/v1"
	"github.com/sirupsen/logrus"
)

func (s *SpotServiceServer) SubGameEvent(request *proto.SubGameEventRequest, stream proto.SpotService_SubGameEventServer) error {
	s.log.WithField("request", request.String()).Debug("Sub zone state request")

	spotUuid, err := uuid.Parse(request.SpotUuid)
	if err != nil {
		return fmt.Errorf("Couldn't parse spot uuid. " + err.Error())
	}

	spot, ok := s.SpotsMap.Load(spotUuid)
	if !ok {
		return fmt.Errorf("Spot with uuid '%s' couldn't be found", spotUuid)
	}

	if spot.Session == nil {
		return fmt.Errorf("Spot has no active session")
	}

	if spot.Session.GameController == nil {
		return errors.New("GameController in spot is not inited")
	}

	for gameEventI := range spot.Session.GameController.EventsBroadcaster.Listen().Ch {
		switch event := gameEventI.(type) {
		case game_controller.StartGameEvent:
			response := &proto.SubGameEventResponse{
				Event: &proto.SubGameEventResponse_StartGameEvent{
					StartGameEvent: &proto.StartGameEvent{},
				},
			}
			s.log.WithField("response", response.String()).Debug("Start game session event")
			if err := stream.Send(response); err != nil {
				return err
			}

		case game_controller.EndGameEvent:
			response := &proto.SubGameEventResponse{
				Event: &proto.SubGameEventResponse_StopGameEvent{
					StopGameEvent: &proto.StopGameEvent{
						Winner: api_spot_v1_utils.MapStopGameEventWinner(event.Winner),
					},
				},
			}

			s.log.WithField("response", response.String()).Debug("Stop game session event")
			if err := stream.Send(response); err != nil {
				return err
			}

		default:
			logrus.Fatalf("Unimplemented: %v", event)

		}
	}
	return nil
}
