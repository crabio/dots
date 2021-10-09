package api_user_v1

import (
	// External
	"context"
	"errors"
	"math/rand"
	"time"

	// Internal
	user_v1 "github.com/iakrevetkho/archaeopteryx/example/proto/gen/user/v1"
)

var (
	EMPTY_NAME_ERROR     = errors.New("name shouldn't be empty")
	EMPTY_PASSWORD_ERROR = errors.New("password shouldn't be empty")
)

func (s *UserServiceServer) AddUser(ctx context.Context, request *user_v1.AddUserRequest) (*user_v1.AddUserResponse, error) {
	s.log.WithField("request", request.String()).Trace("Add user request")

	if request.GetName() == "" {
		return nil, EMPTY_NAME_ERROR
	}
	if request.GetPassword() == "" {
		return nil, EMPTY_PASSWORD_ERROR
	}

	rand.Seed(time.Now().UnixNano())
	userId := rand.Uint32()
	s.log.WithField("id", userId).Trace("User ID generated")

	response := user_v1.AddUserResponse{Id: userId}
	s.log.WithField("response", response.String()).Trace("Add user response")

	return &response, nil
}
