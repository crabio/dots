package api_spot_v1

import (
	// External
	"fmt"

	"github.com/google/uuid"

	// Internal
	proto "github.com/iakrevetkho/dots/server/proto/gen/spot/v1"
)

func (s *SpotServiceServer) GetSpotStartFlag(request *proto.GetSpotStartFlagRequest, stream proto.SpotService_GetSpotStartFlagServer) error {
	s.log.WithField("request", request.String()).Trace("Get spot start flag request")

	spotUuid, err := uuid.Parse(request.SpotUuid)
	if err != nil {
		return fmt.Errorf("Couldn't parse spot uuid. " + err.Error())
	}

	spot, ok := s.SpotsMap.Load(spotUuid)
	if !ok {
		return fmt.Errorf("Spot with uuid '%s' couldn't be found", spotUuid)
	}

	for isActiveI := range spot.IsActiveBroadcaster.Listen().Ch {
		isActive := isActiveI.(bool)

		response := &proto.GetSpotStartFlagResponse{
			IsActive: isActive,
		}

		s.log.WithField("response", response.String()).Debug("Get spot start flag response")
		if err := stream.Send(response); err != nil {
			return err
		}
	}
	return nil
}
