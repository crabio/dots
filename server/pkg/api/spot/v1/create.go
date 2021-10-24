package api_spot_v1

import (
	// External
	"context"
	"time"

	"github.com/golang/geo/s2"
	"github.com/google/uuid"

	// Internal
	data "github.com/iakrevetkho/dots/server/pkg/api/spot/v1/data"
	proto "github.com/iakrevetkho/dots/server/proto/gen/spot/v1"
)

func (s *SpotServiceServer) CreateSpot(ctx context.Context, request *proto.CreateSpotRequest) (*proto.CreateSpotResponse, error) {
	s.log.WithField("request", request.String()).Debug("Create spot request")

	spotUUID := uuid.New()

	s.SpotsMap.Store(spotUUID, data.Spot{
		Position:        s2.LatLngFromDegrees(request.Position.Latitude, request.Position.Longitude),
		ZoneRadius:      request.Radius,
		ScanPeriod:      time.Second * time.Duration(request.ScanPeriodInSeconds),
		ZonePeriod:      time.Second * time.Duration(request.ZonePeriodInSeconds),
		PlayersStateMap: data.NewPlayerStateMap(),
	})
	s.log.WithField("uuid", spotUUID).Debug("New spot created")

	response := proto.CreateSpotResponse{
		SpotUuid: spotUUID.String(),
	}
	s.log.WithField("response", response.String()).Trace("Create spot response")

	return &response, nil
}
