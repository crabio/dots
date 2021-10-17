package api_spot_v1

import (
	// External
	"fmt"
	"io"
	"time"

	"github.com/golang/geo/s2"
	"github.com/google/uuid"
	"github.com/sirupsen/logrus"

	// Internal
	geo_utils "github.com/iakrevetkho/dots/server/pkg/utils/geo"
	proto "github.com/iakrevetkho/dots/server/proto/gen/spot/v1"
)

func (s *SpotServiceServer) SendPlayerPosition(stream proto.SpotService_SendPlayerPositionServer) error {
	s.log.Trace("Open send user position stream")

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
		s.log.WithField("request", request.String()).Trace("Open send user position stream")

		spotUuid, err := uuid.Parse(request.SpotUuid)
		if err != nil {
			return fmt.Errorf("Couldn't parse spot uuid. " + err.Error())
		}

		s.SpotsMapMx.Lock()
		spot, ok := s.SpotsMap[spotUuid]
		s.SpotsMapMx.Unlock()
		if !ok {
			return fmt.Errorf("Spot with uuid '%s' couldn't be found", spotUuid)
		}

		playerUuid, err := uuid.Parse(request.PlayerUuid)
		if err != nil {
			return fmt.Errorf("Couldn't parse user uuid. " + err.Error())
		}

		// Update player state
		spot.Lock()
		playerState, ok := spot.PlayersStateMap[playerUuid]
		if !ok {
			// New player
			// TODO Players should be inited on game start
			spot.PlayersStateMap[playerUuid] = PlayerState{
				Position: s2.LatLngFromDegrees(request.Position.Latitude, request.Position.Longitude),
				Health:   100,
			}
		} else {
			playerState.Position = s2.LatLngFromDegrees(request.Position.Latitude, request.Position.Longitude)

			// Check player health
			playerToSpotDistance := geo_utils.AngleToM(spot.Position.Distance(playerState.Position))
			if playerToSpotDistance > float64(spot.ZoneRadius) {
				// Start goroutine with ticket for health decreasing
				if !playerState.ZoneDamageActice {
					startPlayerZoneDamage(&spot, playerUuid)
				}
			} else {
				// Stop player zone damage if needed
				if playerState.ZoneDamageActice {
					playerState.StopZoneDmgCh <- true
				}
			}
			// TODO Check that needed
			// spot.PlayersStateMap[playerUuid] = playerState
		}
		spot.Unlock()

		s.log.WithFields(logrus.Fields{
			"spotUuid":   spotUuid,
			"playeruuid": playerUuid,
			"position":   request.Position,
		}).Trace("Player position updated")
	}
}

func startPlayerZoneDamage(spot *Spot, playerUuid uuid.UUID) {
	go func() {
		// TODO Move zone damage to consts
		const zoneDamage = 15
		// TODO Move zone damage period to consts
		const zoneDamagePeriod = 1 * time.Second

		spot.Lock()
		playerState := spot.PlayersStateMap[playerUuid]
		playerState.ZoneDamageActice = true
		spot.Unlock()

		damageTicker := time.NewTicker(zoneDamagePeriod)
		for {
			select {
			case <-playerState.StopZoneDmgCh:
				spot.Lock()
				playerState.ZoneDamageActice = false
				spot.Unlock()
				return
			case _ = <-damageTicker.C:
				logrus.Printf("Damage for %v", playerState)
				spot.Lock()
				playerState.Health -= zoneDamage
				spot.Unlock()
				logrus.Printf("Damaged %v", playerState)
			}
		}
	}()
}
