package command

import (
	"context"
	"time"

	"github.com/golang/geo/s2"
	"github.com/iakrevetkho/dots/server/internal/spot/domain/spot"
	"github.com/sirupsen/logrus"
)

type CreateSpot struct {
	Position        s2.LatLng
	RadiusInM       float32
	ScanPeriod      time.Duration
	ZonePeriod      time.Duration
	SessionDuration time.Duration
}

type CreateSpotHandler struct {
	repo spot.Repository
}

func NewCreateSpotHandler(repo spot.Repository) CreateSpotHandler {
	if repo == nil {
		panic("nil repo service")
	}

	return CreateSpotHandler{repo: repo}
}

func (h CreateSpotHandler) Handle(ctx context.Context, cmd CreateSpot) error {
	spot := spot.NewSpot(cmd.Position, cmd.RadiusInM, cmd.ScanPeriod, cmd.ZonePeriod, cmd.SessionDuration)

	if err := h.repo.CreateSpot(ctx, spot); err != nil {
		logrus.WithError(err).WithFields(logrus.Fields{"cmd": cmd, "step": "create spot in repo"}).Error("CreateSpot cmd complete with error")
		return err
	}

	logrus.WithField("cmd", cmd).Debug("CreateSpot cmd complete successfully")
	return nil
}
