package api_spot_v1

import ( // External
	// Internal
	"fmt"
	"io"

	"github.com/google/uuid"
	proto "github.com/iakrevetkho/dots/server/proto/gen/spot/v1"
)

func (s *SpotServiceServer) SendPlayerPosition(stream proto.SpotService_SendPlayerPositionServer) error {
	s.log.Trace("Open send user position stream")

	for {
		position, err := stream.Recv()
		if err == io.EOF {
			// End of stream
			s.log.Trace("Close user position stream")
			return stream.SendAndClose(&proto.SendPlayerPositionResponse{})
		}
		if err != nil {
			return err
		}
		s.log.WithField("position", position.String()).Trace("Open send user position stream")

		spotUuid, err := uuid.Parse(position.SpotUuid)
		if err != nil {
			return fmt.Errorf("Couldn't parse spot uuid. " + err.Error())
		}

		spot, ok := s.SpotsMap[spotUuid]
		if !ok {
			return fmt.Errorf("Spot with uuid '%s' couldn't be found", spotUuid)
		}

		playerUuid, err := uuid.Parse(position.PlayerUuid)
		if err != nil {
			return fmt.Errorf("Couldn't parse user uuid. " + err.Error())
		}

		spot.PlayerPositions[playerUuid] = Position{
			Latitude:  position.Position.Latitude,
			Longitude: position.Position.Longitude,
		}
	}
}
