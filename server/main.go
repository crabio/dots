package main

import (
	// External

	"github.com/jinzhu/configor"
	"github.com/sirupsen/logrus"

	// Internal
	"github.com/iakrevetkho/archaeopteryx"
	archaeopteryx_config "github.com/iakrevetkho/archaeopteryx/config"
	"github.com/iakrevetkho/archaeopteryx/example/docs"
	api_hello_world_v1 "github.com/iakrevetkho/archaeopteryx/example/pkg/api/hello_world/v1"
	api_user_v1 "github.com/iakrevetkho/archaeopteryx/example/pkg/api/user/v1"
	api_user_v2 "github.com/iakrevetkho/archaeopteryx/example/pkg/api/user/v2"
	archaeopteryx_service "github.com/iakrevetkho/archaeopteryx/service"
)

func main() {
	log := logrus.WithField("component", "main")

	// Init archeopteryx config
	conf := new(archaeopteryx_config.Config)
	if err := configor.Load(conf, "config.yml"); err != nil {
		log.WithError(err).Fatal("couldn't init config")
	}

	// Add swagger docs
	conf.Docs.DocsFS = &docs.Swagger
	conf.Docs.DocsRootFolder = "swagger"

	// Init services
	services := []archaeopteryx_service.IServiceServer{
		api_hello_world_v1.New(),
		api_user_v1.New(),
		api_user_v2.New(),
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
