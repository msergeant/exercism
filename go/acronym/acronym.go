// Package acronym converts phrases into acronyms
package acronym

import "strings"

const testVersion = 3

// Abbreviate returns a phrase as its acronym.
func Abbreviate(s string) string {
	result := ""
	previousSpace := true
	for _, ch := range s {
		chStr := string(ch)
		if previousSpace {
			result += strings.ToUpper(chStr)
		}

		previousSpace = chStr == " " || chStr == "-"
	}

	return result
}
