package api_user_v1_test

import (
	// External
	"context"
	"testing"

	"github.com/stretchr/testify/assert"

	// Internal
	api_user "github.com/iakrevetkho/archaeopteryx/example/pkg/api/user/v1"
	"github.com/iakrevetkho/archaeopteryx/example/proto/gen/user/v1"
)

func TestGet(t *testing.T) {
	s := api_user.New()

	_, err := s.GetUser(context.Background(), &user.GetUserRequest{})
	assert.Error(t, err)

	response, err := s.GetUser(context.Background(), &user.GetUserRequest{Id: 1})
	assert.NoError(t, err)
	assert.Equal(t, "Bobby", response.Name)
	assert.Equal(t, "qwerty", response.Password)
}
