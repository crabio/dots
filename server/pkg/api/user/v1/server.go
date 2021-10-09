package api_user_v1

import (
	// External
	"context"

	"github.com/grpc-ecosystem/grpc-gateway/v2/runtime"
	"github.com/sirupsen/logrus"
	"google.golang.org/grpc"

	// Internal
	user_v1 "github.com/iakrevetkho/archaeopteryx/example/proto/gen/user/v1"
	"github.com/iakrevetkho/archaeopteryx/logger"
)

type UserServiceServer struct {
	log *logrus.Entry
	// Required to have revese compatability
	user_v1.UnimplementedUserServiceServer
}

func New() *UserServiceServer {
	server := new(UserServiceServer)
	server.log = logger.CreateLogger("grpc-user-v1")
	return server
}

// RegisterGrpc - HealthServiceServer's method to registrate gRPC service server handlers
func (s *UserServiceServer) RegisterGrpc(sr grpc.ServiceRegistrar) error {
	user_v1.RegisterUserServiceServer(sr, s)
	s.log.Logger.Debug("Service gRPC registered")
	return nil
}

// RegisterGrpcProxy - HealthServiceServer's method to registrate gRPC proxy service server handlers
func (s *UserServiceServer) RegisterGrpcProxy(ctx context.Context, mux *runtime.ServeMux, conn *grpc.ClientConn) error {
	if err := user_v1.RegisterUserServiceHandler(ctx, mux, conn); err != nil {
		return err
	}
	s.log.Logger.Debug("Service gRPC proxy registered")
	return nil
}
