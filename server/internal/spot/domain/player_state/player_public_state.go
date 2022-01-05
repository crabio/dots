package player_state

import (
	"github.com/golang/geo/s2"
	"github.com/google/uuid"
)

// TODO Think about deprecation
type PlayerPublicState struct {
	PlayerUuid uuid.UUID
	Position   s2.LatLng
	Health     float32
}
