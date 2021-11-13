package api_spot_v1_utils

import (
	"github.com/iakrevetkho/dots/server/pkg/game_controller"
	proto "github.com/iakrevetkho/dots/server/proto/gen/spot/v1"
	"github.com/sirupsen/logrus"
)

func MapStopGameEventWinner(in game_controller.GameWinner) proto.StopGameEvent_GameWinner {
	switch in {
	case game_controller.SessionWinner_HunterWins:
		return proto.StopGameEvent_GAME_WINNER_HUNTER

	case game_controller.SessionWinner_VictimsWins:
		return proto.StopGameEvent_GAME_WINNER_VICTIMS

	case game_controller.SessionWinner_Draw:
		return proto.StopGameEvent_GAME_WINNER_DRAW

	default:
		logrus.Fatalf("Unimplemented: %v", in)
		return -1
	}
}
