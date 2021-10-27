package zone

import (
	// External

	"testing"
	"time"

	"github.com/golang/geo/s2"
	"github.com/iakrevetkho/dots/server/pkg/utils/geo"
	"github.com/stretchr/testify/assert"
	// Internal
)

func TestNewRadius(t *testing.T) {
	assert.Equal(t, uint32(100), newRadius(200))
	assert.Equal(t, uint32(50), newRadius(100))
	assert.Equal(t, uint32(25), newRadius(50))
	assert.Equal(t, uint32(12), newRadius(25))
	assert.Equal(t, uint32(0), newRadius(10))
	assert.Equal(t, uint32(0), newRadius(0))
}

func TestRandomR(t *testing.T) {
	// Test min random
	randFloat = func() float64 {
		return 0
	}
	r := randomR(200, 100)
	assert.Equal(t, float64(0), r)

	// Test max random
	randFloat = func() float64 {
		return 1
	}
	r = randomR(200, 100)
	assert.Equal(t, float64(100), r)
}

func TestNextZone(t *testing.T) {
	// Test max random
	randFloat = func() float64 {
		return 1
	}

	c := NewController(s2.LatLng{Lat: 0, Lng: 0}, 200, time.Second*30)

	assert.Equal(t, s2.LatLng{Lat: 0, Lng: 0}, c.CurrentZone.Position)
	assert.Equal(t, uint32(200), c.CurrentZone.Radius)
	assert.Equal(t, float32(0.25), c.CurrentZone.Damage)
	assert.Nil(t, c.NextZone)

	c.Next()

	assert.Equal(t, s2.LatLng{Lat: 0, Lng: 0}, c.CurrentZone.Position)
	assert.Equal(t, uint32(200), c.CurrentZone.Radius)
	assert.Equal(t, float32(0.25), c.CurrentZone.Damage)

	assert.Equal(t, s2.LatLng{Lat: 1.5696098420815538e-05, Lng: -3.844435338030709e-21}, c.NextZone.Position)
	assert.Equal(t, uint32(100), c.NextZone.Radius)
	assert.Equal(t, float32(0.5), c.NextZone.Damage)

	assert.Equal(t, uint16(99), uint16(geo.AngleToM(c.NextZone.Position.Distance(c.CurrentZone.Position))))
}

func TestTickZone(t *testing.T) {
	// Test max random
	randFloat = func() float64 {
		return 0.5
	}
	timeNow = func() time.Time {
		return time.Date(2000, 1, 1, 0, 0, 0, 0, time.UTC)
	}

	c := NewController(s2.LatLng{Lat: 0, Lng: 0}, 200, time.Second*30)

	assert.Equal(t, s2.LatLng{Lat: 0, Lng: 0}, c.CurrentZone.Position)
	assert.Equal(t, uint32(200), c.CurrentZone.Radius)
	assert.Equal(t, float32(0.25), c.CurrentZone.Damage)
	assert.Nil(t, c.NextZone)

	c.Next()

	assert.Equal(t, s2.LatLng{Lat: 0, Lng: 0}, c.CurrentZone.Position)
	assert.Equal(t, uint32(200), c.CurrentZone.Radius)
	assert.Equal(t, float32(0.25), c.CurrentZone.Damage)

	assert.Equal(t, s2.LatLng{Lat: -1.1098817631530128e-05, Lng: 1.359213148677356e-21}, c.NextZone.Position)
	assert.Equal(t, uint32(100), c.NextZone.Radius)
	assert.Equal(t, float32(0.5), c.NextZone.Damage)

	assert.Equal(t, uint16(70), uint16(geo.AngleToM(c.NextZone.Position.Distance(c.CurrentZone.Position))))

	// Tick zone
	curZone := c.Tick()

	assert.Equal(t, s2.LatLng{Lat: 0, Lng: 0}, curZone.Position)
	assert.Equal(t, uint32(200), curZone.Radius)
	assert.Equal(t, float32(0.25), curZone.Damage)

}
