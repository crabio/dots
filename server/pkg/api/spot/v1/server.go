package api_spot_v1

import (
	"context"
	"time"

	"github.com/grpc-ecosystem/grpc-gateway/v2/runtime"
	"github.com/sirupsen/logrus"
	"google.golang.org/grpc"

	"github.com/iakrevetkho/archaeopteryx/logger"
	"github.com/iakrevetkho/dots/server/pkg/spot"
	proto "github.com/iakrevetkho/dots/server/proto/gen/spot/v1"
)

type SpotServiceServer struct {
	log *logrus.Entry
	// Required to have revese compatability
	proto.UnimplementedSpotServiceServer

	playersPosUpdatePeriod time.Duration

	// Map with all spots on server
	//
	// key - spot UUID
	// value - spot session data
	SpotsMap *spot.SpotMap
}

func New(playersPosUpdatePeriod time.Duration) *SpotServiceServer {
	s := new(SpotServiceServer)
	s.log = logger.CreateLogger("spot-v1")
	s.playersPosUpdatePeriod = playersPosUpdatePeriod
	s.SpotsMap = spot.NewSpotMap()

	return s
}

// RegisterGrpc - HealthServiceServer's method to registrate gRPC service server handlers
func (s *SpotServiceServer) RegisterGrpc(sr grpc.ServiceRegistrar) error {
	proto.RegisterSpotServiceServer(sr, s)
	s.log.Logger.Debug("Service gRPC registered")
	return nil
}

// RegisterGrpcProxy - HealthServiceServer's method to registrate gRPC proxy service server handlers
func (s *SpotServiceServer) RegisterGrpcProxy(ctx context.Context, mux *runtime.ServeMux, conn *grpc.ClientConn) error {
	if err := proto.RegisterSpotServiceHandler(ctx, mux, conn); err != nil {
		return err
	}
	s.log.Logger.Debug("Service gRPC proxy registered")
	return nil
}
