package api_hello_world_v1

import (
	"context"

	hello_world_v1 "github.com/iakrevetkho/archaeopteryx/example/proto/gen/hello_world/v1"
)

func (s *HelloServiceServer) SayHello(ctx context.Context, request *hello_world_v1.SayHelloRequest) (*hello_world_v1.SayHelloResponse, error) {
	s.log.WithField("request", request.String()).Trace("Say hello request")

	response := hello_world_v1.SayHelloResponse{Message: request.GetName() + " world"}
	s.log.WithField("response", response.String()).Trace("Say hello response")

	return &response, nil
}
