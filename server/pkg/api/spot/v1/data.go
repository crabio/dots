package api_spot_v1

import (
	// External
	"time"

	"github.com/google/uuid"
	geo "gopkg.in/billups/golang-geo.v2"
	// Internal
)

type Spot struct {
	Position   geo.Point
	Radius     int32
	ScanPeriod time.Duration
	ZonePeriod time.Duration
	// Map with players posiiton
	//
	// key - player uuid
	// value - player state
	PlayersStateMap map[uuid.UUID]PlayerState
}

type PlayerState struct {
	Position geo.Point
	Health   int16
}
