// Package triangle determines the type of triangle based on side lengths
package triangle

import (
	"math"
)

const (
	NaT         = iota // not a triangle
	Equ                // equilateral
	Iso                // isosceles
	Sca                // scalene
	testVersion = 3
)

type Kind int

func KindFromSides(a, b, c float64) Kind {
	switch {
	case invalidSide(a) || invalidSide(b) || invalidSide(c):
		return NaT
	case a+b < c || a+c < b || b+c < a:
		return NaT
	case a == b && a == c:
		return Equ
	case a == b || a == c || b == c:
		return Iso
	}

	return Sca
}

func invalidSide(n float64) bool {
	return n == 0 || math.IsNaN(n) || math.IsInf(n, 0)
}
