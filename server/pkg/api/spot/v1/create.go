package api_spot_v1

import (
	// External
	"context"
	"time"

	"github.com/google/uuid"

	// Internal
	proto "github.com/iakrevetkho/dots/server/proto/gen/spot/v1"
)

func (s *SpotServiceServer) CreateSpot(ctx context.Context, request *proto.CreateSpotRequest) (*proto.CreateSpotResponse, error) {
	s.log.WithField("request", request.String()).Trace("Create spot request")

	spotUUID := uuid.New()

	s.SpotsMap[spotUUID] = Spot{
		Position: Position{
			Latitude:  request.Position.Latitude,
			Longitude: request.Position.Longitude,
		},
		Radius:              request.Radius,
		ScanPeriod:          time.Second * time.Duration(request.ScanPeriodInSeconds),
		ZonePeriod:          time.Second * time.Duration(request.ZonePeriodInSeconds),
		PlayersPositionsMap: make(map[uuid.UUID]Position),
	}
	s.log.WithField("uuid", spotUUID).Debug("New spot created")

	response := proto.CreateSpotResponse{
		SpotUuid: spotUUID.String(),
	}
	s.log.WithField("response", response.String()).Trace("Create spot response")

	return &response, nil
}
