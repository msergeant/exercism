// Package triangle determines the type of triangle based on side lengths
package triangle

import (
	"math"
)

const testVersion = 3

type Kind int

const NaT Kind = 0 // not a triangle
const Equ Kind = 1 // equilateral
const Iso Kind = 2 // isosceles
const Sca Kind = 3 // scalene

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
