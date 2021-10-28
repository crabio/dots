package zone

import (
	"errors"
	"math"
	"math/rand"
	"time"

	"github.com/golang/geo/s2"
	"github.com/google/uuid"
	"github.com/iakrevetkho/archaeopteryx/logger"
	"github.com/iakrevetkho/dots/server/pkg/utils/geo"
	"github.com/sirupsen/logrus"
)

const (
	zoneTickPeriod = time.Millisecond * 500
)

// Functions as variable required for unit tests
var (
	randFloat = rand.Float64
)

type Controller struct {
	log *logrus.Entry

	minZoneRadiusInMeter       uint32
	zoneSpeedInMetersPerSecond float64

	prevZone             *Zone
	CurrentZone          *Zone
	NextZone             *Zone
	nextZoneCreationTime *time.Time

	nextZonePeriod time.Duration
	nextZoneTimer  *time.Timer

	// Delay between next zone creation and zone tick
	nextZoneDelay      time.Duration
	nextZoneDelayTimer *time.Timer

	zoneTicker *time.Ticker
}

func NewController(spotId uuid.UUID, spotPosition s2.LatLng, spotRadiusInMeter uint32, minZoneRadiusInMeter uint32, nextZonePeriod time.Duration, nextZoneDelay time.Duration, zoneSpeedInKilometersPerHour float64) *Controller {
	c := new(Controller)
	c.log = logger.CreateLogger("zone-controller-" + spotId.String())
	c.minZoneRadiusInMeter = minZoneRadiusInMeter
	c.zoneSpeedInMetersPerSecond = zoneSpeedInKilometersPerHour * 1000 / 3600
	c.CurrentZone = NewZone(spotPosition, spotRadiusInMeter, minZoneRadiusInMeter)
	c.nextZonePeriod = nextZonePeriod
	c.nextZoneDelay = nextZoneDelay

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
func (c *Controller) Next(now time.Time) {
	c.NextZone = nextZone(c.CurrentZone, c.minZoneRadiusInMeter)
	c.nextZoneCreationTime = &now
	// Also save current zone as previous zone
	c.prevZone = c.CurrentZone
}

// Approximate zone to next zone
//
// Function returns current zone, flag about last tick (true if it was last tick), error
func (c *Controller) Tick(now time.Time) (*Zone, bool, error) {
	// Check that we have inited new zone
	if c.NextZone == nil {
		return nil, false, errors.New("NextZone is not inited for tick. Call Next() method to init next zone first.")
	}

	// Calc zone overal distance in meters from previous
	overalDistance := geo.AngleToM(c.prevZone.Position.Distance(c.NextZone.Position))

	// Calc zone distance from farrest circle point to next zone in meters
	zoneMaxCircleDistance := float64(c.prevZone.Radius-c.NextZone.Radius) + overalDistance

	// Calc zone time duration in seconds for transition to next zone
	zoneOveralTransDuration := zoneMaxCircleDistance / c.zoneSpeedInMetersPerSecond

	// Calc current zone transition percentage from overal distance to next zone
	secondsFromTickStart := now.Sub(*c.nextZoneCreationTime).Seconds()

	// If we have some time from start
	if secondsFromTickStart != 0 {
		transitionPercentage := 1 - (zoneOveralTransDuration-secondsFromTickStart)/zoneOveralTransDuration

		if transitionPercentage >= 1.0 {
			// Next zone reached

			c.CurrentZone = c.NextZone
			c.NextZone = nil
			c.prevZone = nil
			c.nextZoneCreationTime = nil

			// This is last tick
			return c.CurrentZone, true, nil

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

			lat := c.prevZone.Position.Lat + geo.MToAngle(latDistance)
			lng := c.prevZone.Position.Lng + geo.MToAngle(lngDistance)

			// Zone radius = Next zone radius + (Prev zone radius - Next zone radius) * transition percentage
			radius := float64(c.NextZone.Radius) + float64(c.prevZone.Radius-c.NextZone.Radius)*(1-transitionPercentage)

			c.CurrentZone = NewZone(s2.LatLng{Lat: lat, Lng: lng}, uint32(radius), 10)
		}
	}

	return c.CurrentZone, false, nil
}

// Function for starting zone changing workflow
//
// Timer for new zone -> Timer for next zone delay -> Tick zone till next zone reached -> Restart next zone timer
// Workflow will work till zero zone reached
func (c *Controller) Start() error {
	if c.nextZoneTimer != nil {
		return errors.New("nextZoneTimer is already inited")
	}

	go func() {
		// While current zone radius is bigger that 0
		for c.CurrentZone.Radius > 0 {
			c.nextZoneTimer = time.NewTimer(c.nextZonePeriod)
			<-c.nextZoneTimer.C
			c.nextZoneTimer = nil
			c.log.Debug("Next zone timer fired")

			c.Next(time.Now().UTC())
			// TODO Add sending next zone event to players

			c.nextZoneDelayTimer = time.NewTimer(c.nextZoneDelay)
			<-c.nextZoneDelayTimer.C
			c.nextZoneDelayTimer = nil
			c.log.Debug("Next zone delay timer fired")
			// TODO Add sending next zone delay end event to players

			c.zoneTicker = time.NewTicker(zoneTickPeriod)

		tickerLoop:
			for range c.zoneTicker.C {
				c.log.Debug("Next zone tick")
				_, lastTick, err := c.Tick(time.Now().UTC())
				if err != nil {
					c.log.Error("Couldn't Tick next zone. " + err.Error())
				}
				// TODO Add sending current zone to players

				// Check that it was last tick
				if lastTick {
					c.log.Debug("Last tick. Stop zone ticker")
					c.zoneTicker.Stop()
					c.zoneTicker = nil
					// Go away from ticker loop
					break tickerLoop
				}
			}
		}
		c.log.Debug("Next zone loop end")
	}()

	return nil
}

// Creates new zone inside current zone
func nextZone(zone *Zone, minZoneRadiusInMeter uint32) *Zone {
	newR := newRadius(zone.Radius, minZoneRadiusInMeter)

	// Calc radius of random area
	r := randomR(zone.Radius, newR)
	theta := randFloat() * 2 * math.Pi

	lat := zone.Position.Lat + geo.MToAngle(r*math.Cos(theta))
	lng := zone.Position.Lng + geo.MToAngle(r*math.Sin(theta))

	return NewZone(s2.LatLng{Lat: lat, Lng: lng}, newR, 10)
}

// Creeate random radius as circle position for new zone
func randomR(curZoneR uint32, newZoneR uint32) float64 {
	return float64((curZoneR - newZoneR)) * math.Sqrt(randFloat())
}

func newRadius(radius uint32, minZoneRadiusInMeter uint32) uint32 {
	if radius > minZoneRadiusInMeter*2 {
		return radius / 2
	} else {
		return 0
	}
}
