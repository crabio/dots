package api_spot_v1

import (
	// External
	"time"

	"github.com/golang/geo/s2"
	"github.com/google/uuid"
	// Internal
)

type Spot struct {
	Position   s2.LatLng
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
	Position s2.LatLng
	Health   int16
}
