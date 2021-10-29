package api_spot_v1

import (
	// External

	"fmt"

	"github.com/google/uuid"

	// Internal

	"github.com/iakrevetkho/dots/server/pkg/zone"
	proto "github.com/iakrevetkho/dots/server/proto/gen/spot/v1"
)

func (s *SpotServiceServer) SubZoneEvent(request *proto.SubZoneEventRequest, stream proto.SpotService_SubZoneEventServer) error {
	s.log.WithField("request", request.String()).Trace("Get players positions")

	spotUuid, err := uuid.Parse(request.SpotUuid)
	if err != nil {
		return fmt.Errorf("Couldn't parse spot uuid. " + err.Error())
	}

	spot, ok := s.SpotsMap.Load(spotUuid)
	if !ok {
		return fmt.Errorf("Spot with uuid '%s' couldn't be found", spotUuid)
	}

	for zoneEventI := range spot.ZoneController.ZoneEventBroadcaster.Listen().Ch {
		switch zoneEventI.(type) {
		case zone.StartNextZoneTimerEvent:
			event := zoneEventI.(zone.StartNextZoneTimerEvent)
			response := &proto.SubZoneEventResponse{
				Event: &proto.SubZoneEventResponse_StartNextZoneTimerEvent{
					StartNextZoneTimerEvent: &proto.StartNextZoneTimerEvent{
						CurrentZone: &proto.ZoneState{
							Position: &proto.Position{
								Latitude:  event.CurrentZone.Position.Lat.Degrees(),
								Longitude: event.CurrentZone.Position.Lng.Degrees(),
							},
							RadiusInM: int32(event.CurrentZone.Radius),
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
			event := zoneEventI.(zone.StartZoneDelayTimerEvent)
			response := &proto.SubZoneEventResponse{
				Event: &proto.SubZoneEventResponse_StartZoneDelayTimerEvent{
					StartZoneDelayTimerEvent: &proto.StartZoneDelayTimerEvent{
						CurrentZone: &proto.ZoneState{
							Position: &proto.Position{
								Latitude:  event.CurrentZone.Position.Lat.Degrees(),
								Longitude: event.CurrentZone.Position.Lng.Degrees(),
							},
							RadiusInM: int32(event.CurrentZone.Radius),
							Damage:    event.CurrentZone.Damage,
						},
						NextZone: &proto.ZoneState{
							Position: &proto.Position{
								Latitude:  event.NextZone.Position.Lat.Degrees(),
								Longitude: event.NextZone.Position.Lng.Degrees(),
							},
							RadiusInM: int32(event.NextZone.Radius),
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
			event := zoneEventI.(zone.ZoneTickEvent)
			response := &proto.SubZoneEventResponse{
				Event: &proto.SubZoneEventResponse_ZoneTickEvent{
					ZoneTickEvent: &proto.ZoneTickEvent{
						CurrentZone: &proto.ZoneState{
							Position: &proto.Position{
								Latitude:  event.CurrentZone.Position.Lat.Degrees(),
								Longitude: event.CurrentZone.Position.Lng.Degrees(),
							},
							RadiusInM: int32(event.CurrentZone.Radius),
							Damage:    event.CurrentZone.Damage,
						},
						NextZone: &proto.ZoneState{
							Position: &proto.Position{
								Latitude:  event.NextZone.Position.Lat.Degrees(),
								Longitude: event.NextZone.Position.Lng.Degrees(),
							},
							RadiusInM: int32(event.NextZone.Radius),
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
