package mock

import (
	"math/rand"
	"sync"
)

// Functions as variable required for unit tests
var (
	RandFloat = rand.Float64
	// This mutex is required to prevent race in unit tests
	RandFloatMx = sync.RWMutex{}
)
