package spot

import "context"

type Repository interface {
	CreateSpot(ctx context.Context, tr *Spot) error
}
