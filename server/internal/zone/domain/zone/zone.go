package zone

import (
	"math"

	"github.com/golang/geo/s2"
)

const (
	maxZoneDamage = 5.0
)

type Zone struct {
	Position s2.LatLng
	// Zone radius in meters
	Radius float32
	// Zone damage per period
	Damage float32
}

func NewZone(position s2.LatLng, radius float32, minZoneRadiusInMeter float32) *Zone {
	z := new(Zone)

	z.Position = position
	z.Radius = radius
	z.Damage = calcDamage(radius, minZoneRadiusInMeter)

	return z
}

// TODO Refactor
// Calc damage to have target damage at last zone
func calcDamage(radius float32, minZoneRadiusInMeter float32) float32 {
	if radius > minZoneRadiusInMeter {
		zonesCount := math.Log2(float64(radius)) - math.Log2(float64(minZoneRadiusInMeter))

		return float32(maxZoneDamage / (math.Pow(2, zonesCount)))
	} else {
		return maxZoneDamage
	}
}
