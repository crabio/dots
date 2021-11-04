package game_controller

type StartSessionEvent struct {
}

type EndSessionEvent struct {
	Winner SessionWinner
}

type SessionWinner int64

const (
	SessionWinner_HunterWins  SessionWinner = 0
	SessionWinner_VictimsWins               = 1
	SessionWinner_Draw                      = 2
)
