package api_hello_world_v1

import (
	// External
	"context"

	"github.com/grpc-ecosystem/grpc-gateway/v2/runtime"
	"github.com/sirupsen/logrus"
	"google.golang.org/grpc"

	// Internal
	hello_world_v1 "github.com/iakrevetkho/archaeopteryx/example/proto/gen/hello_world/v1"
	"github.com/iakrevetkho/archaeopteryx/logger"
)

type HelloServiceServer struct {
	log *logrus.Entry
	// Required to have revese compatability
	hello_world_v1.UnimplementedHelloServiceServer
}

func New() *HelloServiceServer {
	server := new(HelloServiceServer)
	server.log = logger.CreateLogger("grpc-hello-world-v1")
	return server
}

// RegisterGrpc - HealthServiceServer's method to registrate gRPC service server handlers
func (s *HelloServiceServer) RegisterGrpc(sr grpc.ServiceRegistrar) error {
	hello_world_v1.RegisterHelloServiceServer(sr, s)
	s.log.Logger.Debug("Service gRPC registered")
	return nil
}

// RegisterGrpcProxy - HealthServiceServer's method to registrate gRPC proxy service server handlers
func (s *HelloServiceServer) RegisterGrpcProxy(ctx context.Context, mux *runtime.ServeMux, conn *grpc.ClientConn) error {
	if err := hello_world_v1.RegisterHelloServiceHandler(ctx, mux, conn); err != nil {
		return err
	}
	s.log.Logger.Debug("Service gRPC proxy registered")
	return nil
}
