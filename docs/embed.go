package docs

import (
	"embed"
)

//go:embed swagger/*
var Swagger embed.FS
