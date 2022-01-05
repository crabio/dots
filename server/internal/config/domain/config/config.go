package config

import (
	"time"

	archaeopteryx_config "github.com/iakrevetkho/archaeopteryx/config"
)

type Config struct {
	ServerConfig archaeopteryx_config.Config

	// Ticker period for sending players position
	PlayersPositionsUpdatePeriod time.Duration `default:"200ms" env:"PLAYERS_POS_UPDATE_PERIOD"`
}
