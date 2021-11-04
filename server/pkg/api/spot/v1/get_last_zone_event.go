package api_spot_v1

import (
	// External
	"context"
	"errors"
	"fmt"

	"github.com/google/uuid"
	"github.com/sirupsen/logrus"

	// Internal
	"github.com/iakrevetkho/dots/server/pkg/zone"
	proto "github.com/iakrevetkho/dots/server/proto/gen/spot/v1"
)

func (s *SpotServiceServer) GetLastZoneEvent(ctx context.Context, request *proto.GetLastZoneEventRequest) (*proto.GetLastZoneEventResponse, error) {
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

	if spot.Session.ZoneController == nil {
		return nil, errors.New("ZoneController is not inited")
	}

	if spot.Session.ZoneController.LastZoneEvent == nil {
		return nil, errors.New("LastZoneEvent is not inited")
	}

	logrus.WithField("spot.ZoneController.LastZoneEvent", spot.Session.ZoneController.LastZoneEvent).Debug("spot.ZoneController.LastZoneEvent")

	switch spot.Session.ZoneController.LastZoneEvent.(type) {
	case zone.StartNextZoneTimerEvent:
		event := spot.Session.ZoneController.LastZoneEvent.(zone.StartNextZoneTimerEvent)
		response := &proto.GetLastZoneEventResponse{
			Event: &proto.GetLastZoneEventResponse_StartNextZoneTimerEvent{
				StartNextZoneTimerEvent: &proto.StartNextZoneTimerEvent{
					CurrentZone: &proto.ZoneState{
						Position: &proto.Position{
							Latitude:  event.CurrentZone.Position.Lat.Degrees(),
							Longitude: event.CurrentZone.Position.Lng.Degrees(),
						},
						RadiusInM: event.CurrentZone.Radius,
						Damage:    event.CurrentZone.Damage,
					},
					NextZoneTimestamp: event.NextZoneTime.Unix(),
				},
			},
		}
		s.log.WithField("response", response.String()).Debug("Last event: Start next zone timer event")
		return response, nil

	case zone.StartZoneDelayTimerEvent:
		event := spot.Session.ZoneController.LastZoneEvent.(zone.StartZoneDelayTimerEvent)
		response := &proto.GetLastZoneEventResponse{
			Event: &proto.GetLastZoneEventResponse_StartZoneDelayTimerEvent{
				StartZoneDelayTimerEvent: &proto.StartZoneDelayTimerEvent{
					CurrentZone: &proto.ZoneState{
						Position: &proto.Position{
							Latitude:  event.CurrentZone.Position.Lat.Degrees(),
							Longitude: event.CurrentZone.Position.Lng.Degrees(),
						},
						RadiusInM: event.CurrentZone.Radius,
						Damage:    event.CurrentZone.Damage,
					},
					NextZone: &proto.ZoneState{
						Position: &proto.Position{
							Latitude:  event.NextZone.Position.Lat.Degrees(),
							Longitude: event.NextZone.Position.Lng.Degrees(),
						},
						RadiusInM: event.NextZone.Radius,
						Damage:    event.NextZone.Damage,
					},
					ZoneTickStartTimestamp: event.ZoneTickStartTime.Unix(),
				},
			},
		}
		s.log.WithField("response", response.String()).Debug("Last event: Start zone delay timer event")
		return response, nil

	case zone.ZoneTickEvent:
		event := spot.Session.ZoneController.LastZoneEvent.(zone.ZoneTickEvent)
		response := &proto.GetLastZoneEventResponse{
			Event: &proto.GetLastZoneEventResponse_ZoneTickEvent{
				ZoneTickEvent: &proto.ZoneTickEvent{
					CurrentZone: &proto.ZoneState{
						Position: &proto.Position{
							Latitude:  event.CurrentZone.Position.Lat.Degrees(),
							Longitude: event.CurrentZone.Position.Lng.Degrees(),
						},
						RadiusInM: event.CurrentZone.Radius,
						Damage:    event.CurrentZone.Damage,
					},
					NextZone: &proto.ZoneState{
						Position: &proto.Position{
							Latitude:  event.NextZone.Position.Lat.Degrees(),
							Longitude: event.NextZone.Position.Lng.Degrees(),
						},
						RadiusInM: event.NextZone.Radius,
						Damage:    event.NextZone.Damage,
					},
				},
			},
		}
		s.log.WithField("response", response.String()).Debug("Last event: Zone tick event")
		return response, nil

	default:
		return nil, errors.New("Unknown last zone event")
	}
}
