package api_spot_v1

import (
	// External
	"context"

	"github.com/google/uuid"
	"github.com/grpc-ecosystem/grpc-gateway/v2/runtime"
	"github.com/sirupsen/logrus"
	"google.golang.org/grpc"

	// Internal
	"github.com/iakrevetkho/archaeopteryx/logger"
	proto "github.com/iakrevetkho/dots/server/proto/gen/spot/v1"
)

type SpotServiceServer struct {
	log *logrus.Entry
	// Required to have revese compatability
	proto.UnimplementedSpotServiceServer

	// Map with all spots on server
	//
	// key - spot UUID
	// value - spot session data
	spotsMap map[uuid.UUID]struct{}
}

func New() *SpotServiceServer {
	s := new(SpotServiceServer)
	s.log = logger.CreateLogger("spot-v1")
	s.spotsMap = make(map[uuid.UUID]struct{})

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