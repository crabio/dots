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

func TestAdd(t *testing.T) {
	s := api_user.New()

	_, err := s.AddUser(context.Background(), &user.AddUserRequest{})
	assert.Error(t, err)

	_, err = s.AddUser(context.Background(), &user.AddUserRequest{FirstName: "Bob"})
	assert.Error(t, err)

	_, err = s.AddUser(context.Background(), &user.AddUserRequest{FirstName: "Bob", LastName: "Dilan"})
	assert.Error(t, err)

	response, err := s.AddUser(context.Background(), &user.AddUserRequest{FirstName: "Bob", LastName: "Dilan", Password: "ququ"})
	assert.NoError(t, err)
	assert.NotEqual(t, 0, response.Id)
}
