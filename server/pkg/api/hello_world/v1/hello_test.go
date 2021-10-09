package api_hello_world_v1_test

import (
	// External
	"context"
	"testing"

	"github.com/stretchr/testify/assert"

	// Internal
	api_hello_world "github.com/iakrevetkho/archaeopteryx/example/pkg/api/hello_world/v1"
	"github.com/iakrevetkho/archaeopteryx/example/proto/gen/hello_world/v1"
)

func TestHello(t *testing.T) {
	s := api_hello_world.New()

	testHello(t, s, &hello_world.SayHelloRequest{}, " world")
	testHello(t, s, &hello_world.SayHelloRequest{Name: ""}, " world")
	testHello(t, s, &hello_world.SayHelloRequest{Name: "hello"}, "hello world")
}

func testHello(t *testing.T, s *api_hello_world.HelloServiceServer, r *hello_world.SayHelloRequest, responseMsg string) {
	response, err := s.SayHello(context.Background(), r)

	assert.NoError(t, err)
	assert.Equal(t, responseMsg, response.Message)
}
