// Package twofer implements a simple response function
package twofer

import "strings"

// ShareWith returns a response in the form of
// "One for %s, one for me."
// When an empty string is input, "you" is the default
func ShareWith(s string) string {
	if s == "" {
		s = "you"
	}

	return strings.Join([]string{"One for ", s, ", one for me."}, "")
}
