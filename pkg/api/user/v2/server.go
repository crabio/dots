package api_user_v2

import (
	// External
	"context"

	"github.com/grpc-ecosystem/grpc-gateway/v2/runtime"
	"github.com/sirupsen/logrus"
	"google.golang.org/grpc"

	// Internal
	user_v2 "github.com/iakrevetkho/archaeopteryx/example/proto/gen/user/v2"
	"github.com/iakrevetkho/archaeopteryx/logger"
)

type UserServiceServer struct {
	log *logrus.Entry
	// Required to have revese compatability
	user_v2.UnimplementedUserServiceServer
}

func New() *UserServiceServer {
	server := new(UserServiceServer)
	server.log = logger.CreateLogger("grpc-user-v2")
	return server
}

// RegisterGrpc - HealthServiceServer's method to registrate gRPC service server handlers
func (s *UserServiceServer) RegisterGrpc(sr grpc.ServiceRegistrar) error {
	user_v2.RegisterUserServiceServer(sr, s)
	s.log.Logger.Debug("Service gRPC registered")
	return nil
}

// RegisterGrpcProxy - HealthServiceServer's method to registrate gRPC proxy service server handlers
func (s *UserServiceServer) RegisterGrpcProxy(ctx context.Context, mux *runtime.ServeMux, conn *grpc.ClientConn) error {
	if err := user_v2.RegisterUserServiceHandler(ctx, mux, conn); err != nil {
		return err
	}
	s.log.Logger.Debug("Service gRPC proxy registered")
	return nil
}
