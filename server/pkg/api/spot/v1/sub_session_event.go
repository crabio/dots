package api_spot_v1

import (
	"errors"
	"fmt"

	"github.com/google/uuid"
	"github.com/iakrevetkho/dots/server/pkg/game_controller"
	proto "github.com/iakrevetkho/dots/server/proto/gen/spot/v1"
	"github.com/sirupsen/logrus"
)

func (s *SpotServiceServer) SubSessionEvent(request *proto.SubSessionEventRequest, stream proto.SpotService_SubSessionEventServer) error {
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

	for gameSessionEventI := range spot.Session.GameController.EventsBroadcaster.Listen().Ch {
		switch event := gameSessionEventI.(type) {
		case game_controller.StartSessionEvent:
			response := &proto.SubSessionEventResponse{
				Event: &proto.SubSessionEventResponse_StartSessionEvent{
					StartSessionEvent: &proto.StartSessionEvent{},
				},
			}
			s.log.WithField("response", response.String()).Debug("Start game session event")
			if err := stream.Send(response); err != nil {
				return err
			}

		case game_controller.EndSessionEvent:
			response := &proto.SubSessionEventResponse{
				Event: &proto.SubSessionEventResponse_StopSessionEvent{
					StopSessionEvent: &proto.StopSessionEvent{
						Winner: mapStopSessionEventWinner(event.Winner),
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

func mapStopSessionEventWinner(in game_controller.SessionWinner) proto.StopSessionEvent_SessionWinner {
	switch in {
	case game_controller.SessionWinner_HunterWins:
		return proto.StopSessionEvent_HunterWins

	case game_controller.SessionWinner_VictimsWins:
		return proto.StopSessionEvent_VictimsWins

	case game_controller.SessionWinner_Draw:
		return proto.StopSessionEvent_Draw

	default:
		logrus.Fatalf("Unimplemented: %v", in)
		return -1
	}
}
