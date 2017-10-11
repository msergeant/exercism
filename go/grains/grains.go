// Package grains is used to find the number of grains that
// would appear on a given square of a chess board when the
// number doubles on every subsequent square
package grains

import (
	"fmt"
	"math"
)

const testVersion = 1

// Square returns the number of grains on a given square
func Square(n int) (output uint64, err error) {
	if n < 1 || n > 64 {
		err = fmt.Errorf("n must be between 1 and 64")
		return
	}

	output = uint64(math.Pow(2, float64(n-1)))

	return
}

// Total returns the number of grains on all the squares
func Total() (output uint64) {
	output = 1
	for i := 0; i < 63; i += 1 {
		output = output * 2
	}
	output = output - 1 + output
	return
}
