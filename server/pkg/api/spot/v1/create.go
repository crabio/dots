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

	s.spotsMap[spotUUID] = Spot{
		Longitude:  request.Longitude,
		Latiitude:  request.Latiitude,
		Radius:     request.Radius,
		ScanPeriod: time.Second * time.Duration(request.ScanPeriodInSeconds),
		ZonePeriod: time.Second * time.Duration(request.ZonePeriodInSeconds),
	}
	s.log.WithField("uuid", spotUUID).Debug("New spot created")

	response := proto.CreateSpotResponse{
		Uuid: spotUUID.String(),
	}
	s.log.WithField("response", response.String()).Trace("Create spot response")

	return &response, nil
}
