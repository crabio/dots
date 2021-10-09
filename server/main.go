package main

import (
	// External

	"github.com/jinzhu/configor"
	"github.com/sirupsen/logrus"

	// Internal
	"github.com/iakrevetkho/archaeopteryx"
	archaeopteryx_config "github.com/iakrevetkho/archaeopteryx/config"
	archaeopteryx_service "github.com/iakrevetkho/archaeopteryx/service"
	"github.com/iakrevetkho/dots/server/docs"
	api_spot_v1 "github.com/iakrevetkho/dots/server/pkg/api/spot/v1"
)

func main() {
	log := logrus.WithField("component", "main")

	// Init archeopteryx config
	conf := new(archaeopteryx_config.Config)
	if err := configor.Load(conf, "config.yml"); err != nil {
		log.WithError(err).Fatal("couldn't init config")
	}

	// Set log file name
	conf.Log.Filename = "/var/log/dots/log"

	// Add swagger docs
	conf.Docs.DocsFS = &docs.Swagger
	conf.Docs.DocsRootFolder = "swagger"

	// Init services
	services := []archaeopteryx_service.IServiceServer{
		api_spot_v1.New(),
	}

	// Create archeopteryx server
	server, err := archaeopteryx.New(conf, services)
	if err != nil {
		log.WithError(err).Fatal("couldn't init server")
	}

	// Run archeopteryx server
	log.Info("Run server")
	if err := server.Run(); err != nil {
		log.WithError(err).Fatal("couldn't run server")
	}
}
