// Package etl provides functions for transforming scrabble score data from
// legacy format to the current format
package etl

import (
	"strings"
)

const testVersion = 1

// Transform returns the result of converting map[int][]string into map[string]int
func Transform(letterScores map[int][]string) (output map[string]int) {
	output = make(map[string]int)
	for k, v := range letterScores {
		for _, s := range v {
			output[strings.ToLower(s)] = k
		}
	}
	return
}
