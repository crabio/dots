package api_spot_v1

import ( // External
	// Internal
	"fmt"
	"io"

	"github.com/google/uuid"
	proto "github.com/iakrevetkho/dots/server/proto/gen/spot/v1"
	"github.com/sirupsen/logrus"
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
				Position: Position{
					Latitude:  request.Position.Latitude,
					Longitude: request.Position.Longitude,
				},
				Health: 100,
			}
		} else {
			playerState.Position = Position{
				Latitude:  request.Position.Latitude,
				Longitude: request.Position.Longitude,
			}
			spot.PlayersStateMap[playerUuid] = playerState
		}

		s.log.WithFields(logrus.Fields{
			"spotUuid":   spotUuid,
			"playeruuid": playerUuid,
			"position":   request.Position,
		}).Trace("Player position updated")
	}
}
