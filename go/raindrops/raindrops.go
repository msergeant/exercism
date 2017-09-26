// Package raindrops is a form of fizzbuzz using Pling Plang Plong
package raindrops

import "fmt"

const testVersion = 3

// Convert returns different values based on factors of the number
// If the number has 3 as a factor, outputs 'Pling'.
// If the number has 5 as a factor, outputs 'Plang'.
// If the number has 7 as a factor, outputs 'Plong'.
// If the number does not have 3, 5, or 7 as a factor,
// just passes the number's digits straight through.
func Convert(n int) string {
	var resultString string
	if n%3 == 0 {
		resultString = fmt.Sprintf("%sPling", resultString)
	}
	if n%5 == 0 {
		resultString = fmt.Sprintf("%sPlang", resultString)
	}
	if n%7 == 0 {
		resultString = fmt.Sprintf("%sPlong", resultString)
	}

	if len(resultString) == 0 {
		resultString = fmt.Sprintf("%d", n)
	}

	return resultString
}
