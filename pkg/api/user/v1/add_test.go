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

func TestAdd(t *testing.T) {
	s := api_user.New()

	_, err := s.AddUser(context.Background(), &user.AddUserRequest{})
	assert.Error(t, err)

	_, err = s.AddUser(context.Background(), &user.AddUserRequest{Name: "Bob"})
	assert.Error(t, err)

	response, err := s.AddUser(context.Background(), &user.AddUserRequest{Name: "Bob", Password: "ququ"})
	assert.NoError(t, err)
	assert.NotEqual(t, 0, response.Id)
}
