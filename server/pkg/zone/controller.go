package zone

import (
	"math"
	"math/rand"
	"time"

	"github.com/golang/geo/s2"
	"github.com/iakrevetkho/dots/server/pkg/utils/geo"
)

const (
	minZoneRadiusInMeter = 10
)

var randFloat = rand.Float64

type Controller struct {
	ZonePeriod time.Duration

	CurrentZone *Zone
	NextZone    *Zone
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
