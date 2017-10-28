// Package pythagorean provides functions for working with pythagorean triples
package pythagorean

import (
	"math"
)

const testVersion = 1

type Triplet [3]int

// Range returns a list of all Pythagorean triplets with sides in the
// range min to max inclusive.
func Range(min, max int) (output []Triplet) {
	for a := min; a < max; a++ {
		for b := a; b < max; b++ {
			triple, c := isTriplet(a, b)
			if triple && c <= max {
				output = append(output, Triplet{a, b, c})
			}
		}
	}
	return
}

/// Sum returns a list of all Pythagorean triplets where the sum a+b+c
// (the perimeter) is equal to p.
func Sum(p int) (output []Triplet) {
	candidates := Range(1, p/2)
	for _, triplet := range candidates {
		if triplet[0]+triplet[1]+triplet[2] == p {
			output = append(output, triplet)
		}
	}
	return
}

func isTriplet(a int, b int) (bool, int) {
	cSquared := a*a + b*b
	if isSquare(cSquared) {
		return true, int(math.Floor(math.Sqrt(float64(cSquared))))
	}
	return false, 0
}

func isSquare(num int) bool {
	root := math.Sqrt(float64(num))
	return root == math.Floor(root)
}
