package geo

import (
	// External
	"github.com/golang/geo/s1"
)

// The Earth's mean radius in kilometers (according to NASA).
const earthRadiusKm = 6371010

// AngleToM converts a angle to a distance on the Earth's surface in meters.
func AngleToM(angle s1.Angle) float64 {
	return float64(angle) * earthRadiusKm
}

// MToAngle converts distance on the Earth's surface in meters to a angle.
func MToAngle(distance float64) s1.Angle {
	return s1.Angle(distance / earthRadiusKm)
}
