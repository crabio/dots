package zone

import (
	"math"
	"time"

	"github.com/golang/geo/s2"
)

const (
	zoneDamagePeriod = time.Second * 2
	maxZoneDamage    = 5.0
)

type Zone struct {
	Position s2.LatLng
	// Zone radius in meters
	Radius uint32
	// Zone damage per period
	Damage float32
}

func NewZone(position s2.LatLng, radius uint32, minZoneRadiusInMeter uint32) *Zone {
	z := new(Zone)

	z.Position = position
	z.Radius = radius
	z.Damage = calcDamage(radius, minZoneRadiusInMeter)

	return z
}

// Calc damage to have target damage at last zone
func calcDamage(radius uint32, minZoneRadiusInMeter uint32) float32 {
	if radius > minZoneRadiusInMeter {
		zonesCount := math.Log2(float64(radius)) - math.Log2(float64(minZoneRadiusInMeter))

		return float32(maxZoneDamage / (math.Pow(2, zonesCount)))
	} else {
		return maxZoneDamage
	}
}
