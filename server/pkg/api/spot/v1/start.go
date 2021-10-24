package api_spot_v1

import (
	// External
	"context"
	"fmt"

	"github.com/google/uuid"

	// Internal

	proto "github.com/iakrevetkho/dots/server/proto/gen/spot/v1"
)

func (s *SpotServiceServer) StartSpot(ctx context.Context, request *proto.StartSpotRequest) (*proto.StartSpotResponse, error) {
	s.log.WithField("request", request.String()).Debug("Join to spot request")

	spotUuid, err := uuid.Parse(request.SpotUuid)
	if err != nil {
		return nil, fmt.Errorf("Couldn't parse spot uuid. " + err.Error())
	}

	spot, ok := s.SpotsMap.Load(spotUuid)
	if !ok {
		return nil, fmt.Errorf("Spot with uuid '%s' couldn't be found", spotUuid)
	}

	if err := spot.FSM.Event("start"); err != nil {
		return nil, fmt.Errorf("Couldn't start spot with uuid '%s'. %s", spotUuid, err.Error())
	}

	response := proto.StartSpotResponse{}

	return &response, nil
}
