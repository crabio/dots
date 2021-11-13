package mock

import (
	"sync"
	"time"
)

// Functions as variable required for unit tests
var (
	TimeNow = time.Now
	// This mutex is required to prevent race in unit tests
	TimeNowMx = sync.RWMutex{}
)
