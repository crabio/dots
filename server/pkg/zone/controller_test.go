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

	c.Next(time.Now())

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

	c := NewController(s2.LatLng{Lat: 0, Lng: 0}, 200, time.Second*30)

	assert.Equal(t, s2.LatLng{Lat: 0, Lng: 0}, c.CurrentZone.Position)
	assert.Equal(t, uint32(200), c.CurrentZone.Radius)
	assert.Equal(t, float32(0.25), c.CurrentZone.Damage)
	assert.Nil(t, c.NextZone)

	c.Next(time.Date(2000, 1, 1, 0, 0, 0, 0, time.UTC))

	assert.Equal(t, s2.LatLng{Lat: 0, Lng: 0}, c.CurrentZone.Position)
	assert.Equal(t, uint32(200), c.CurrentZone.Radius)
	assert.Equal(t, float32(0.25), c.CurrentZone.Damage)

	assert.Equal(t, s2.LatLng{Lat: -1.1098817631530128e-05, Lng: 1.359213148677356e-21}, c.NextZone.Position)
	assert.Equal(t, uint32(100), c.NextZone.Radius)
	assert.Equal(t, float32(0.5), c.NextZone.Damage)

	assert.Equal(t, uint16(70), uint16(geo.AngleToM(c.NextZone.Position.Distance(c.CurrentZone.Position))))

	// Zero zone tick
	curZone, err := c.Tick(time.Date(2000, 1, 1, 0, 0, 0, 0, time.UTC))
	assert.NoError(t, err)
	assert.Equal(t, uint32(0), uint32(geo.AngleToM(c.prevZone.Position.Distance(curZone.Position)))+c.prevZone.Radius-curZone.Radius)
	assert.Equal(t, uint32(170), uint32(geo.AngleToM(c.NextZone.Position.Distance(curZone.Position)))+curZone.Radius-c.NextZone.Radius)
	assert.Equal(t, uint32(200), curZone.Radius)
	assert.Equal(t, float32(0.25), curZone.Damage)

	// 1 second zone tick
	curZone, err = c.Tick(time.Date(2000, 1, 1, 0, 0, 1, 0, time.UTC))
	assert.NoError(t, err)
	assert.Equal(t, uint32(3), uint32(geo.AngleToM(c.prevZone.Position.Distance(curZone.Position)))+c.prevZone.Radius-curZone.Radius)
	assert.Equal(t, uint32(169), uint32(geo.AngleToM(c.NextZone.Position.Distance(curZone.Position)))+curZone.Radius-c.NextZone.Radius)
	assert.Equal(t, uint32(198), curZone.Radius)
	assert.Equal(t, float32(0.25252524), curZone.Damage)

	// 10 seconds zone tick
	curZone, err = c.Tick(time.Date(2000, 1, 1, 0, 0, 10, 0, time.UTC))
	assert.NoError(t, err)
	assert.Equal(t, uint32(28), uint32(geo.AngleToM(c.prevZone.Position.Distance(curZone.Position)))+c.prevZone.Radius-curZone.Radius)
	assert.Equal(t, uint32(165), uint32(geo.AngleToM(c.NextZone.Position.Distance(curZone.Position)))+curZone.Radius-c.NextZone.Radius)
	assert.Equal(t, uint32(183), curZone.Radius)
	assert.Equal(t, float32(0.27322406), curZone.Damage)

	// 30 seconds zone tick
	curZone, err = c.Tick(time.Date(2000, 1, 1, 0, 0, 10, 0, time.UTC))
	assert.NoError(t, err)
	assert.Equal(t, uint32(28), uint32(geo.AngleToM(c.prevZone.Position.Distance(curZone.Position)))+c.prevZone.Radius-curZone.Radius)
	assert.Equal(t, uint32(165), uint32(geo.AngleToM(c.NextZone.Position.Distance(curZone.Position)))+curZone.Radius-c.NextZone.Radius)
	assert.Equal(t, uint32(183), curZone.Radius)
	assert.Equal(t, float32(0.27322406), curZone.Damage)

	// 1 min zone tick
	curZone, err = c.Tick(time.Date(2000, 1, 1, 0, 1, 0, 0, time.UTC))
	assert.NoError(t, err)
	assert.Equal(t, uint32(167), uint32(geo.AngleToM(c.prevZone.Position.Distance(curZone.Position)))+c.prevZone.Radius-curZone.Radius)
	assert.Equal(t, uint32(141), uint32(geo.AngleToM(c.NextZone.Position.Distance(curZone.Position)))+curZone.Radius-c.NextZone.Radius)
	assert.Equal(t, uint32(102), curZone.Radius)
	assert.Equal(t, float32(0.49019608), curZone.Damage)

	// 1 minute 10 seconds zone tick
	curZone, err = c.Tick(time.Date(2000, 1, 1, 0, 1, 10, 0, time.UTC))
	assert.NoError(t, err)
	assert.Nil(t, c.prevZone)
	assert.Nil(t, c.NextZone)
	assert.Equal(t, s2.LatLng{Lat: -1.1098817631530128e-05, Lng: 1.359213148677356e-21}, curZone.Position)
	assert.Equal(t, uint32(100), curZone.Radius)
	assert.Equal(t, float32(0.5), curZone.Damage)

	// 2 minutes zone tick
	curZone, err = c.Tick(time.Date(2000, 1, 1, 0, 2, 0, 0, time.UTC))
	assert.Error(t, err)
}
