package api_user_v2_test

import (
	// External
	"context"
	"testing"

	"github.com/stretchr/testify/assert"

	// Internal
	api_user "github.com/iakrevetkho/archaeopteryx/example/pkg/api/user/v2"
	"github.com/iakrevetkho/archaeopteryx/example/proto/gen/user/v2"
)

func TestGet(t *testing.T) {
	s := api_user.New()

	_, err := s.GetUser(context.Background(), &user.GetUserRequest{})
	assert.Error(t, err)

	response, err := s.GetUser(context.Background(), &user.GetUserRequest{Id: 1})
	assert.NoError(t, err)
	assert.Equal(t, "Bobby", response.FirstName)
	assert.Equal(t, "Twist", response.LastName)
	assert.Equal(t, "qwerty", response.Password)
}
