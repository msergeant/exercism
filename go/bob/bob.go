// Package bob represents a lackadaisical teenager. In conversation, his responses are very limited.
// Bob answers "Sure." if you ask him a question.
// He answers "Whoa, chill out!" if you yell at him.
// He says "Fine. Be that way!" if you address him without actually saying
// anything.
// He answers "Whatever." to anything else.
package bob

import (
	"regexp"
	"strings"
)

const testVersion = 3

// Hey returns "Sure." if you ask him a question
// Hey returns "Whoa, chill out!" if you yell at him.
// Hey returns "Fine. Be that way!" if you address him without actually saying
// anything.
// Hey returns "Whatever." to anything else.
func Hey(statement string) string {
	trimmedStatement := strings.TrimSpace(statement)
	switch {
	case isSilence(trimmedStatement):
		return "Fine. Be that way!"
	case isYell(trimmedStatement):
		return "Whoa, chill out!"
	case isQuestion(trimmedStatement):
		return "Sure."
	}

	return "Whatever."
}

func isQuestion(s string) bool {
	return s[len(s)-1] == '?'
}

func isYell(s string) bool {
	allCaps, _ := regexp.MatchString("[A-Z]", s)
	return allCaps && s == strings.ToUpper(s)
}

func isSilence(s string) bool {
	return len(s) == 0
}
