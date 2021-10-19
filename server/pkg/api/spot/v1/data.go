package api_spot_v1

import (
	// External
	"sync"
	"time"

	"github.com/golang/geo/s2"
	"github.com/google/uuid"
	// Internal
)

type Spot struct {
	sync.Mutex

	Position s2.LatLng
	// Zone radius in meters
	ZoneRadius int32
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

	// Zone damage

	// Flag indicies that server has goroutine for zone damage for player
	ZoneDamageActice bool
	// Channel for stoping damage by zone onto player
	StopZoneDmgCh chan bool

	// Channel for sending state about players states
	Sub *chan PlayerState
}
