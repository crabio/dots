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
		if !ok {
			return fmt.Errorf("Spot with uuid '%s' couldn't be found", spotUuid)
		}

		playerUuid, err := uuid.Parse(request.PlayerUuid)
		if err != nil {
			return fmt.Errorf("Couldn't parse user uuid. " + err.Error())
		}

		// Update player state
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
				s.log.Debugf("Player distance %f > %d zone radius", playerToSpotDistance, spot.ZoneRadius)
				// Start goroutine with ticket for health decreasing
				if !playerState.ZoneDamageActice {
					s.startPlayerZoneDamage(spotUuid, playerUuid)
				}
			} else {
				// Stop player zone damage if needed
				if playerState.ZoneDamageActice {
					playerState.StopZoneDmgCh <- true
				}
			}

			// Update player state
			spot.PlayersStateMap[playerUuid] = playerState

			// Send player state to subscriptions which requires it
			for _, v := range spot.PlayersStateMap {
				// TODO Add checks for distance, scanning and etc
				// Check that we have subscription
				if v.Sub != nil {
					// Send data to subscription channel
					(*v.Sub) <- PlayerPublicState{
						PlayerUuid: playerUuid,
						Position:   playerState.Position,
						Health:     playerState.Health,
					}
				}
			}
		}
		s.SpotsMap[spotUuid] = spot
		s.SpotsMapMx.Unlock()

		s.log.WithFields(logrus.Fields{
			"spotUuid":   spotUuid,
			"playeruuid": playerUuid,
			"position":   request.Position,
		}).Trace("Player position updated")
	}
}

func (s *SpotServiceServer) startPlayerZoneDamage(spotUuid uuid.UUID, playerUuid uuid.UUID) {
	go func() {
		// TODO Move zone damage to consts
		const zoneDamage = 15
		// TODO Move zone damage period to consts
		const zoneDamagePeriod = 1 * time.Second

		s.SpotsMapMx.Lock()
		spot, ok := s.SpotsMap[spotUuid]
		s.SpotsMapMx.Unlock()
		if !ok {
			s.log.Errorf("Spot with uuid '%s' couldn't be found", spotUuid)
			return
		}

		playerState := spot.PlayersStateMap[playerUuid]
		playerState.ZoneDamageActice = true
		// Update state in spot
		spot.PlayersStateMap[playerUuid] = playerState
		s.SpotsMapMx.Lock()
		s.SpotsMap[spotUuid] = spot
		s.SpotsMapMx.Unlock()

		damageTicker := time.NewTicker(zoneDamagePeriod)
		for {
			s.SpotsMapMx.Lock()
			spot, ok := s.SpotsMap[spotUuid]
			if !ok {
				s.log.Errorf("Spot with uuid '%s' couldn't be found", spotUuid)
				return
			}

			select {
			case <-playerState.StopZoneDmgCh:
				playerState := spot.PlayersStateMap[playerUuid]
				playerState.ZoneDamageActice = false
				// Update state in spot
				spot.PlayersStateMap[playerUuid] = playerState
				s.SpotsMap[spotUuid] = spot
				s.SpotsMapMx.Unlock()
				return
			case <-damageTicker.C:
				playerState := spot.PlayersStateMap[playerUuid]
				logrus.Printf("Damage for %v", playerState)
				if playerState.Health <= zoneDamage {
					playerState.Health = 0
					// Update state in spot
					spot.PlayersStateMap[playerUuid] = playerState
					s.SpotsMap[spotUuid] = spot
					logrus.Printf("Death %v", playerState)
					// Stop zone damage
					playerState.StopZoneDmgCh <- true
				} else {
					playerState.Health -= zoneDamage
					// Update state in spot
					spot.PlayersStateMap[playerUuid] = playerState
					s.SpotsMap[spotUuid] = spot
				}
				logrus.Printf("Damaged %v", playerState)
			}
			s.SpotsMapMx.Unlock()
		}
	}()
}
