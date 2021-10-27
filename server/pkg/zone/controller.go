package zone

import (
	"math"
	"math/rand"
	"time"

	"github.com/golang/geo/s2"
	"github.com/iakrevetkho/dots/server/pkg/utils/geo"
)

const (
	minZoneRadiusInMeter         = 10
	zoneSpeedInKilometersPerHour = 10
)

// Functions as variable required for unit tests
var (
	randFloat = rand.Float64
	timeNow   = time.Now().UTC
)

type Controller struct {
	ZonePeriod time.Duration

	prevZone    *Zone
	CurrentZone *Zone
	NextZone    *Zone

	nextZoneCreationTime *time.Time
}

func NewController(zonePosition s2.LatLng, zoneRadius uint32, zonePeriod time.Duration) *Controller {
	c := new(Controller)

	c.CurrentZone = NewZone(zonePosition, zoneRadius)
	c.ZonePeriod = zonePeriod

	return c
}

// 200m
// next zone - 100m after period
// Damage - 0.15.. hp / s

// 100m
// next zone - 50m after period
// Damage - 0.3175 hp / s

// 50m
// next zone - 25m after period
// Damage - 0.625 hp / s

// 25m
// next zone - 12.5m after period
// Damage - 1.25 hp / s

// 12.5m
// next zone - 0m after period
// Damage - 2.5 hp / s

// 0m
// next zone - none
// Damage - 5 hp / s

// Create next zone
func (c *Controller) Next() {
	c.NextZone = nextZone(c.CurrentZone)
	now := timeNow()
	c.nextZoneCreationTime = &now
	// Also save current zone as previous zone
	c.prevZone = c.CurrentZone
}

// Approximate zone to next zone
//
// Function returns current zone
func (c *Controller) Tick() *Zone {
	// Calc zone overal distance in meters from previous
	overalDistance := geo.AngleToM(c.prevZone.Position.Distance(c.NextZone.Position))

	// Calc zone distance from farrest circle point to next zone in meters
	zoneMaxCircleDistance := float64(c.prevZone.Radius-c.NextZone.Radius) + overalDistance

	// Calc zone time duration in seconds for transition to next zone
	zoneOveralTransDuration := zoneMaxCircleDistance / (zoneSpeedInKilometersPerHour * 3600 / 1000)

	// Calc current zone transition percentage from overal distance to next zone
	secondsFromTickStart := timeNow().Sub(*c.nextZoneCreationTime).Seconds()

	// If we have some time from start
	if secondsFromTickStart != 0 {
		transitionPercentage := (secondsFromTickStart - zoneOveralTransDuration) / secondsFromTickStart

		if transitionPercentage >= 1.0 {
			// Next zone reached
			c.CurrentZone = c.NextZone
			c.NextZone = nil
			c.prevZone = nil
			c.nextZoneCreationTime = nil
		} else if transitionPercentage == 0 {
			// Do nothing
		} else {
			// Transition in progress

			// Calc zone current distance in meters from previous
			distance := overalDistance * transitionPercentage

			// Calc zone latitude difference in meters
			latDiff := geo.AngleToM(c.prevZone.Position.Lat - c.NextZone.Position.Lat)

			// Latitude distance = Distance * Latitude diff / Overal Distance
			latDistance := distance * latDiff / overalDistance

			// Calc zone longitude difference in meters
			lngDiff := geo.AngleToM(c.prevZone.Position.Lng - c.NextZone.Position.Lng)

			// Longitude distance = Distance * Longitude diff / Overal Distance
			lngDistance := distance * lngDiff / overalDistance

			lat := c.NextZone.Position.Lat + geo.MToAngle(latDistance)
			lng := c.NextZone.Position.Lng + geo.MToAngle(lngDistance)

			// Zone radius = Next zone radius + (Prev zone radius - Next zone radius) * transition percentage
			radius := float64(c.NextZone.Radius) + float64(c.prevZone.Radius-c.NextZone.Radius)*transitionPercentage

			c.CurrentZone = NewZone(s2.LatLng{Lat: lat, Lng: lng}, uint32(radius))
		}
	}

	return c.CurrentZone
}

// Creates new zone inside current zone
func nextZone(zone *Zone) *Zone {
	newR := newRadius(zone.Radius)

	// Calc radius of random area
	r := randomR(zone.Radius, newR)
	theta := randFloat() * 2 * math.Pi

	lat := zone.Position.Lat + geo.MToAngle(r*math.Cos(theta))
	lng := zone.Position.Lng + geo.MToAngle(r*math.Sin(theta))

	return NewZone(s2.LatLng{Lat: lat, Lng: lng}, newR)
}

// Creeate random radius as circle position for new zone
func randomR(curZoneR uint32, newZoneR uint32) float64 {
	return float64((curZoneR - newZoneR)) * math.Sqrt(randFloat())
}

func newRadius(radius uint32) uint32 {
	if radius > minZoneRadiusInMeter*2 {
		return radius / 2
	} else {
		return 0
	}
}
