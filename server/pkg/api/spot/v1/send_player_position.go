package api_spot_v1

import (
	// External
	"errors"
	"fmt"
	"io"

	"github.com/golang/geo/s2"
	"github.com/google/uuid"
	"github.com/sirupsen/logrus"

	// Internal
	"github.com/iakrevetkho/dots/server/pkg/player_state"
	proto "github.com/iakrevetkho/dots/server/proto/gen/spot/v1"
)

func (s *SpotServiceServer) SendPlayerPosition(stream proto.SpotService_SendPlayerPositionServer) error {
	for {
		request, err := stream.Recv()
		if err == io.EOF {
			// End of stream
			s.log.Trace("Close user position stream")
			return stream.SendAndClose(&proto.SendPlayerPositionResponse{})
		}
		if err != nil {
			return err
		}
		s.log.WithField("request", request.String()).Debug("Received new player's position")

		spotUuid, err := uuid.Parse(request.SpotUuid)
		if err != nil {
			return fmt.Errorf("Couldn't parse spot uuid. " + err.Error())
		}

		spot, ok := s.SpotsMap.Load(spotUuid)
		if !ok {
			return fmt.Errorf("Spot with uuid '%s' couldn't be found", spotUuid)
		}

		playerUuid, err := uuid.Parse(request.PlayerUuid)
		if err != nil {
			return fmt.Errorf("Couldn't parse user uuid. " + err.Error())
		}

		if spot.Session == nil {
			return fmt.Errorf("Spot has no active session")
		}

		// Update player state
		playerState, ok := spot.Session.PlayersStateMap.Load(playerUuid)
		if !ok {
			return fmt.Errorf("Player with uuid '%s' couldn't be found in spot '%s'", playerUuid, spotUuid)
		} else {
			playerState.Position = s2.LatLngFromDegrees(request.Position.Latitude, request.Position.Longitude)

			// Update player state
			if err := spot.Session.NewPlayersState(playerUuid, playerState); err != nil {
				return err
			}

			if playerState.Broadcaster == nil {
				return errors.New("Player state broadcast was closed")
			}

			// Send player state to subscriptions which requires it
			// TODO Add checks for distance, scanning and etc
			playerState.Broadcaster.Send(player_state.PlayerPublicState{
				PlayerUuid: playerUuid,
				Position:   playerState.Position,
				Health:     playerState.Health,
			})
		}
		s.SpotsMap.Store(spotUuid, spot)

		s.log.WithFields(logrus.Fields{
			"spotUuid":   spotUuid,
			"playeruuid": playerUuid,
			"position":   request.Position,
		}).Trace("Player position updated")
	}
}
