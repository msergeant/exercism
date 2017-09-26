// Package hamming provides functions to find the hamming distance between 2 strings
package hamming

import "errors"

const testVersion = 6

// Distance returns the hamming distance between input strings
func Distance(a, b string) (int, error) {
	if len(a) != len(b) {
		return -1, errors.New("Strings must be the same length")
	}
	diffCount := 0

	for i := 0; i < len(a); i++ {
		if a[i] != b[i] {
			diffCount += 1
		}
	}

	return diffCount, nil
}
