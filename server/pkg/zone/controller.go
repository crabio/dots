package zone

import (
	"errors"
	"math"
	"sync"
	"time"

	"github.com/golang/geo/s1"
	"github.com/golang/geo/s2"
	"github.com/google/uuid"
	"github.com/iakrevetkho/archaeopteryx/logger"
	"github.com/iakrevetkho/dots/server/pkg/utils/geo"
	"github.com/iakrevetkho/dots/server/pkg/utils/mock"
	"github.com/sirupsen/logrus"
	"github.com/tjgq/broadcast"
)

const (
	zoneTickPeriod = time.Millisecond * 100
)

type Controller struct {
	sync.RWMutex
	log *logrus.Entry

	minZoneRadiusInM           float32
	zoneSpeedInMetersPerSecond float64

	prevZone             *Zone
	currentZone          *Zone
	nextZone             *Zone
	nextZoneCreationTime *time.Time

	nextZonePeriod time.Duration
	nextZoneTimer  *time.Timer

	// Delay between next zone creation and zone tick
	nextZoneDelay      time.Duration
	nextZoneDelayTimer *time.Timer

	zoneTicker *time.Ticker

	// Channel for sending zone event (one of NextZone, NextZoneTick, ZoneTickEnd)
	ZoneEventBroadcaster *broadcast.Broadcaster
	LastZoneEvent        interface{}
}

func NewController(spotPosition s2.LatLng, spotRadiusInM float32, minZoneRadiusInM float32, nextZonePeriod time.Duration, nextZoneDelay time.Duration, zoneSpeedInKmPerH float64) *Controller {
	c := new(Controller)
	c.log = logger.CreateLogger("zone-controller-" + uuid.NewString())
	c.minZoneRadiusInM = minZoneRadiusInM
	c.zoneSpeedInMetersPerSecond = zoneSpeedInKmPerH * 1000 / 3600
	c.currentZone = NewZone(spotPosition, spotRadiusInM, minZoneRadiusInM)
	c.nextZonePeriod = nextZonePeriod
	c.nextZoneDelay = nextZoneDelay
	c.ZoneEventBroadcaster = broadcast.New(0)

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
func (c *Controller) Next(nextZoneCreationTime time.Time) {
	c.nextZone = nextZone(c.currentZone, c.minZoneRadiusInM)
	c.nextZoneCreationTime = &nextZoneCreationTime
	// Also save current zone as previous zone
	c.prevZone = c.currentZone
}

// Approximate zone to next zone
//
// Function returns current zone, flag about last tick (true if it was last tick), error
func (c *Controller) Tick(now time.Time) (*Zone, bool, error) {
	// Check that we have inited new zone
	if c.nextZone == nil {
		return nil, false, errors.New("NextZone is not inited for tick. Call Next() method to init next zone first.")
	}

	// Calc zone overal distance in meters from previous
	overalDistance := geo.AngleToM(c.prevZone.Position.Distance(c.nextZone.Position))

	// Calc zone distance from farrest circle point to next zone in meters
	zoneMaxCircleDistance := float64(c.prevZone.Radius-c.nextZone.Radius) + overalDistance

	// Calc zone time duration in seconds for transition to next zone
	zoneOveralTransDuration := zoneMaxCircleDistance / c.zoneSpeedInMetersPerSecond

	// Calc current zone transition percentage from overal distance to next zone
	secondsFromTickStart := now.Sub(*c.nextZoneCreationTime).Seconds()

	// If we have some time from start
	if secondsFromTickStart != 0 {
		transitionPercentage := 1 - (zoneOveralTransDuration-secondsFromTickStart)/zoneOveralTransDuration

		if transitionPercentage >= 1.0 {
			// Next zone reached
			c.Lock()
			c.currentZone = c.nextZone
			c.nextZone = nil
			c.prevZone = nil
			c.nextZoneCreationTime = nil
			c.Unlock()

			// This is last tick
			return c.currentZone, true, nil

		} else if transitionPercentage == 0 {
			// Do nothing

		} else {
			// Transition in progress

			// Calc zone latitude difference in meters
			latDiff := (c.nextZone.Position.Lat - c.prevZone.Position.Lat) * s1.Angle(transitionPercentage)

			// Calc zone longitude difference in meters
			lngDiff := (c.nextZone.Position.Lng - c.prevZone.Position.Lng) * s1.Angle(transitionPercentage)

			lat := c.prevZone.Position.Lat + latDiff
			lng := c.prevZone.Position.Lng + lngDiff

			// Zone radius = Next zone radius + (Prev zone radius - Next zone radius) * transition percentage
			radius := float64(c.nextZone.Radius) + float64(c.prevZone.Radius-c.nextZone.Radius)*(1-transitionPercentage)

			c.Lock()
			c.currentZone = NewZone(s2.LatLng{Lat: lat, Lng: lng}, float32(radius), 10)
			c.Unlock()
		}
	}

	return c.currentZone, false, nil
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
		for c.currentZone.Radius > 0 {
			mock.TimeNowMx.Lock()
			startNextZoneTimerEvent := StartNextZoneTimerEvent{
				CurrentZone:  c.currentZone,
				NextZoneTime: mock.TimeNow().UTC().Add(c.nextZonePeriod),
			}
			c.ZoneEventBroadcaster.Send(startNextZoneTimerEvent)
			c.Lock()
			c.LastZoneEvent = startNextZoneTimerEvent
			mock.TimeNowMx.Unlock()
			c.nextZoneTimer = time.NewTimer(c.nextZonePeriod)
			c.Unlock()
			<-c.nextZoneTimer.C
			c.Lock()
			c.nextZoneTimer = nil
			c.Unlock()
			c.log.Debug("Next zone timer fired")

			// Create next zone
			mock.TimeNowMx.Lock()
			// Add delay to current time, because zone will tick after delay
			nextZoneCreationTime := mock.TimeNow().UTC().Add(c.nextZoneDelay)
			c.Next(nextZoneCreationTime)
			mock.TimeNowMx.Unlock()

			// Send next zone event to players
			mock.TimeNowMx.Lock()
			startZoneDelayTimerEvent := StartZoneDelayTimerEvent{
				CurrentZone:       c.currentZone,
				NextZone:          c.nextZone,
				ZoneTickStartTime: nextZoneCreationTime,
			}
			c.ZoneEventBroadcaster.Send(startZoneDelayTimerEvent)
			c.Lock()
			c.LastZoneEvent = startZoneDelayTimerEvent
			mock.TimeNowMx.Unlock()
			c.nextZoneDelayTimer = time.NewTimer(c.nextZoneDelay)
			c.Unlock()
			<-c.nextZoneDelayTimer.C
			c.Lock()
			c.nextZoneDelayTimer = nil
			c.Unlock()
			c.log.Debug("Next zone delay timer fired")

			c.zoneTicker = time.NewTicker(zoneTickPeriod)

		tickerLoop:
			for range c.zoneTicker.C {
				mock.TimeNowMx.Lock()
				curZone, lastTick, err := c.Tick(mock.TimeNow().UTC())
				mock.TimeNowMx.Unlock()
				if err != nil {
					c.log.Error("Couldn't Tick next zone. " + err.Error())
				}

				// Check that it was last tick
				if lastTick {
					c.log.Debug("Last tick. Stop zone ticker")
					c.zoneTicker.Stop()
					c.Lock()
					c.zoneTicker = nil
					c.Unlock()
					// Go away from ticker loop
					break tickerLoop
				} else {
					c.log.WithFields(logrus.Fields{"curZone": curZone, "lastTick": lastTick}).Debug("Next zone tick")
					zoneTickEvent := ZoneTickEvent{
						CurrentZone: curZone,
						NextZone:    c.nextZone,
						LastTick:    lastTick,
					}
					c.ZoneEventBroadcaster.Send(zoneTickEvent)
					c.Lock()
					c.LastZoneEvent = zoneTickEvent
					c.Unlock()
				}
			}
		}
		c.log.Debug("Next zone loop end")
	}()

	return nil
}

func (c *Controller) Stop() {
	c.log.Debug("Stop")
	c.Lock()
	if c.nextZoneTimer != nil {
		c.nextZoneTimer.Stop()
		c.nextZoneTimer = nil
	}
	if c.nextZoneDelayTimer != nil {
		c.nextZoneDelayTimer.Stop()
		c.nextZoneDelayTimer = nil
	}
	if c.zoneTicker != nil {
		c.zoneTicker.Stop()
		c.zoneTicker = nil
	}
	c.Unlock()
	c.log.Debug("Stopped")
}

// Creates new zone inside current zone
func nextZone(zone *Zone, minZoneRadiusInM float32) *Zone {
	newR := newRadius(zone.Radius, minZoneRadiusInM)

	// Calc radius of random area
	r := randomR(zone.Radius, newR)
	theta := mock.RandFloat() * 2 * math.Pi

	lat := zone.Position.Lat + geo.MToAngle(r*math.Cos(theta))
	lng := zone.Position.Lng + geo.MToAngle(r*math.Sin(theta))

	return NewZone(s2.LatLng{Lat: lat, Lng: lng}, newR, 10)
}

// Creeate random radius as circle position for new zone
func randomR(curZoneR float32, newZoneR float32) float64 {
	return float64(curZoneR-newZoneR) * math.Sqrt(mock.RandFloat())
}

func newRadius(radius float32, minZoneRadiusInM float32) float32 {
	if radius > minZoneRadiusInM*2 {
		return radius / 2
	} else {
		return 0
	}
}
