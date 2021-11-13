package game_controller

type StartGameEvent struct {
}

type EndGameEvent struct {
	Winner GameWinner
}

type GameWinner int64

const (
	SessionWinner_HunterWins  GameWinner = 0
	SessionWinner_VictimsWins GameWinner = 1
	SessionWinner_Draw        GameWinner = 2
)
