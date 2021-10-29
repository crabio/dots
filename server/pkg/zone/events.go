package zone

import (
	"time"
)

type StartNextZoneTimerEvent struct {
	CurrentZone  *Zone
	NextZoneTime time.Time
}

type StartZoneDelayTimerEvent struct {
	CurrentZone       *Zone
	NextZone          *Zone
	ZoneTickStartTime time.Time
}

type ZoneTickEvent struct {
	CurrentZone *Zone
	NextZone    *Zone
	LastTick    bool
}
