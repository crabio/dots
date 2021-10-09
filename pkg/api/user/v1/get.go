package api_user_v1

import (
	// External
	"context"
	"errors"

	// Internal
	user_v1 "github.com/iakrevetkho/archaeopteryx/example/proto/gen/user/v1"
)

var (
	WRONG_USER_ID_ERROR = errors.New("wrong user id")
)

func (s *UserServiceServer) GetUser(ctx context.Context, request *user_v1.GetUserRequest) (*user_v1.GetUserResponse, error) {
	s.log.WithField("request", request.String()).Trace("Get user request")

	if request.GetId() == 0 {
		return nil, WRONG_USER_ID_ERROR
	}

	response := user_v1.GetUserResponse{Name: "Bobby", Password: "qwerty"}
	s.log.WithField("response", response.String()).Trace("Get user response")

	return &response, nil
}
