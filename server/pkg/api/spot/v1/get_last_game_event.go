package api_spot_v1

import (
	"context"
	"errors"
	"fmt"

	"github.com/google/uuid"
	api_spot_v1_utils "github.com/iakrevetkho/dots/server/pkg/api/spot/v1/utils"
	"github.com/iakrevetkho/dots/server/pkg/game_controller"
	proto "github.com/iakrevetkho/dots/server/proto/gen/spot/v1"
	"github.com/sirupsen/logrus"
)

func (s *SpotServiceServer) GetLastGameEvent(ctx context.Context, request *proto.GetLastGameEventRequest) (*proto.GetLastGameEventResponse, error) {
	s.log.WithField("request", request.String()).Debug("Get spot request")

	spotUuid, err := uuid.Parse(request.SpotUuid)
	if err != nil {
		return nil, fmt.Errorf("Couldn't parse spot uuid. " + err.Error())
	}

	spot, ok := s.SpotsMap.Load(spotUuid)
	if !ok {
		return nil, fmt.Errorf("Spot with uuid '%s' couldn't be found", spotUuid)
	}

	if spot.Session == nil {
		return nil, errors.New("Session is not inited")
	}

	if spot.Session.GameController == nil {
		return nil, errors.New("GameController is not inited")
	}

	if spot.Session.GameController.LastGameEvent == nil {
		return nil, errors.New("LastGameEvent is not inited")
	}

	logrus.WithField("spot.GameController.LastGameEvent", spot.Session.GameController.LastGameEvent).Debug("spot.GameController.LastGameEvent")

	switch spot.Session.GameController.LastGameEvent.(type) {
	case game_controller.StartGameEvent:
		response := &proto.GetLastGameEventResponse{
			Event: &proto.GetLastGameEventResponse_StartGameEvent{
				StartGameEvent: &proto.StartGameEvent{},
			},
		}
		s.log.WithField("response", response.String()).Debug("Last event: Start game event")
		return response, nil

	case game_controller.EndGameEvent:
		event := spot.Session.GameController.LastGameEvent.(game_controller.EndGameEvent)
		response := &proto.GetLastGameEventResponse{
			Event: &proto.GetLastGameEventResponse_StopGameEvent{
				StopGameEvent: &proto.StopGameEvent{
					Winner: api_spot_v1_utils.MapStopGameEventWinner(event.Winner),
				},
			},
		}
		s.log.WithField("response", response.String()).Debug("Last event: Stop game event")
		return response, nil

	default:
		return nil, errors.New("Unknown last game event")
	}
}
