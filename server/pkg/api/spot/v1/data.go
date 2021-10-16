package api_spot_v1

import (
	// External
	"time"

	"github.com/google/uuid"
	// Internal
)

type Spot struct {
	Position   Position
	Radius     int32
	ScanPeriod time.Duration
	ZonePeriod time.Duration
	// Map with players posiiton
	//
	// key - player uuid
	// value - player position
	PlayersPositionsMap map[uuid.UUID]Position
}

type Position struct {
	Longitude float64
	Latitude  float64
}
