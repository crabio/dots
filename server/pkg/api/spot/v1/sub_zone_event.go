package api_spot_v1

import (
	// External

	"errors"
	"fmt"

	"github.com/google/uuid"

	// Internal

	"github.com/iakrevetkho/dots/server/pkg/zone"
	proto "github.com/iakrevetkho/dots/server/proto/gen/spot/v1"
)

func (s *SpotServiceServer) SubZoneEvent(request *proto.SubZoneEventRequest, stream proto.SpotService_SubZoneEventServer) error {
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

	if spot.Session.ZoneController == nil {
		return errors.New("ZoneController in spot is not inited")
	}

	for zoneEventI := range spot.Session.ZoneController.ZoneEventBroadcaster.Listen().Ch {
		switch event := zoneEventI.(type) {
		case zone.StartNextZoneTimerEvent:
			response := &proto.SubZoneEventResponse{
				Event: &proto.SubZoneEventResponse_StartNextZoneTimerEvent{
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
			s.log.WithField("response", response.String()).Debug("Start next zone timer event")
			if err := stream.Send(response); err != nil {
				return err
			}

		case zone.StartZoneDelayTimerEvent:
			response := &proto.SubZoneEventResponse{
				Event: &proto.SubZoneEventResponse_StartZoneDelayTimerEvent{
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
			s.log.WithField("response", response.String()).Debug("Start zone delay timer event")
			if err := stream.Send(response); err != nil {
				return err
			}

		case zone.ZoneTickEvent:
			response := &proto.SubZoneEventResponse{
				Event: &proto.SubZoneEventResponse_ZoneTickEvent{
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
			s.log.WithField("response", response.String()).Debug("Zone tick event")
			if err := stream.Send(response); err != nil {
				return err
			}
		}
	}
	return nil
}
