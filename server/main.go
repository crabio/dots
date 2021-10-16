package main

import (
	// External

	"github.com/jinzhu/configor"
	"github.com/sirupsen/logrus"

	// Internal
	"github.com/iakrevetkho/archaeopteryx"
	archaeopteryx_service "github.com/iakrevetkho/archaeopteryx/service"
	"github.com/iakrevetkho/dots/server/docs"
	api_spot_v1 "github.com/iakrevetkho/dots/server/pkg/api/spot/v1"
	"github.com/iakrevetkho/dots/server/pkg/config"
)

func main() {
	log := logrus.WithField("component", "main")

	// Init archeopteryx config
	conf := new(config.Config)
	if err := configor.Load(conf, "config.yml"); err != nil {
		log.WithError(err).Fatal("couldn't init config")
	}

	// Add swagger docs
	conf.ServerConfig.Docs.DocsFS = &docs.Swagger
	conf.ServerConfig.Docs.DocsRootFolder = "swagger"

	// Init services
	services := []archaeopteryx_service.IServiceServer{
		api_spot_v1.New(conf.PlayersPositionsUpdatePeriod),
	}

	// Create archeopteryx server
	server, err := archaeopteryx.New(&conf.ServerConfig, services)
	if err != nil {
		log.WithError(err).Fatal("couldn't init server")
	}

	// Run archeopteryx server
	log.Info("Run server")
	if err := server.Run(); err != nil {
		log.WithError(err).Fatal("couldn't run server")
	}
}
