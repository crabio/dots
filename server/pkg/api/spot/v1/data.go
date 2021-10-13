package api_spot_v1

import (
	"time"
	// Internal
)

type Spot struct {
	Longitude  float64
	Latiitude  float64
	Radius     int32
	ScanPeriod time.Duration
	ZonePeriod time.Duration
}
