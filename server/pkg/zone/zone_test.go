package zone

import (
	"testing"

	"github.com/golang/geo/s2"
	"github.com/stretchr/testify/assert"
)

func TestCalcDamage(t *testing.T) {
	assert.Equal(t, float32(0.25), calcDamage(200))
	assert.Equal(t, float32(0.5), calcDamage(100))
	assert.Equal(t, float32(1), calcDamage(50))
	assert.Equal(t, float32(2), calcDamage(25))
	assert.Equal(t, float32(5), calcDamage(10))
	assert.Equal(t, float32(5), calcDamage(0))
}

func TestNewZone(t *testing.T) {
	z := NewZone(s2.LatLng{Lat: 0, Lng: 0}, 200)

	assert.Equal(t, s2.LatLng{Lat: 0, Lng: 0}, z.Position)
	assert.Equal(t, uint32(200), z.Radius)
	assert.Equal(t, float32(0.25), z.Damage)
}
