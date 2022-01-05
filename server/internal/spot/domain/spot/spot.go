package spot

import (
	"sync"
	"time"

	"github.com/golang/geo/s2"
	"github.com/google/uuid"
	"github.com/iakrevetkho/archaeopteryx/logger"
	"github.com/iakrevetkho/dots/server/pkg/player_list"
	"github.com/iakrevetkho/dots/server/pkg/spot_session"
	"github.com/sirupsen/logrus"
	"github.com/tjgq/broadcast"
)

type Spot struct {
	sync.RWMutex

	Id uuid.UUID

	log *logrus.Entry

	Position        s2.LatLng
	RadiusInM       float32
	ScanPeriod      time.Duration
	ZonePeriod      time.Duration
	SessionDuration time.Duration

	// Map with players in spot
	PlayersList *player_list.PlayerList
	// Channel for sending players list on update
	PlayersListBroadcaster *broadcast.Broadcaster

	Session *spot_session.SpotSession
}

func NewSpot(position s2.LatLng, radiusInM float32, scanPeriod time.Duration, zonePeriod time.Duration, sessionDuration time.Duration) *Spot {
	spot := new(Spot)
	spot.Id = uuid.New()
	spot.log = logger.CreateLogger("spot-" + spot.Id.String())
	spot.Position = position
	spot.RadiusInM = radiusInM
	spot.ScanPeriod = scanPeriod
	spot.ZonePeriod = zonePeriod
	spot.SessionDuration = sessionDuration
	spot.PlayersList = player_list.NewPlayerList()
	spot.PlayersListBroadcaster = broadcast.New(0)

	return spot
}
