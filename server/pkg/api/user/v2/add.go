package api_user_v2

import (
	// External
	"context"
	"errors"
	"math/rand"
	"time"

	// Internal
	user_v2 "github.com/iakrevetkho/archaeopteryx/example/proto/gen/user/v2"
)

var (
	NIL_REQUEST_ERROR      = errors.New("request is empty")
	EMPTY_FIRST_NAME_ERROR = errors.New("first name shouldn't be empty")
	EMPTY_LAST_NAME_ERROR  = errors.New("last name shouldn't be empty")
	EMPTY_PASSWORD_ERROR   = errors.New("password shouldn't be empty")
)

func (s *UserServiceServer) AddUser(ctx context.Context, request *user_v2.AddUserRequest) (*user_v2.AddUserResponse, error) {
	s.log.WithField("request", request.String()).Trace("Add user request")

	if request.GetFirstName() == "" {
		return nil, EMPTY_FIRST_NAME_ERROR
	}
	if request.GetLastName() == "" {
		return nil, EMPTY_LAST_NAME_ERROR
	}
	if request.GetPassword() == "" {
		return nil, EMPTY_PASSWORD_ERROR
	}

	rand.Seed(time.Now().UnixNano())
	userId := rand.Uint32()
	s.log.WithField("id", userId).Trace("User ID generated")

	response := user_v2.AddUserResponse{Id: userId}
	s.log.WithField("response", response.String()).Trace("Add user response")

	return &response, nil
}
