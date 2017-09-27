// Package pangram tests whether or not a string contains every letter
package pangram

import (
	"strings"
)

const testVersion = 2

// IsPangram returns true if and only if the string contains every letter a-z
func IsPangram(inString string) bool {
	s := strings.ToLower(inString)
	returnVal := true
	for _, ch := range "abcdefghijklmnopqrstuvwxyz" {
		if !strings.Contains(s, string(ch)) {
			returnVal = false
		}
	}

	return returnVal
}
