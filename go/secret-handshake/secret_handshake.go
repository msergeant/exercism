// Package secret provides a function to convert numbers into secret handshakes
package secret

const testVersion = 2

var actionList = []struct {
	number uint
	action string
}{
	{1, "wink"},
	{2, "double blink"},
	{4, "close your eyes"},
	{8, "jump"},
}

// Handshake returns the list of actions in the handshake
func Handshake(input uint) (handshake []string) {
	for _, action := range actionList {
		if input&action.number == action.number {
			handshake = append(handshake, action.action)
		}
	}
	if input&16 == 16 {
		reverse(handshake)
	}
	return handshake
}

func reverse(s []string) []string {
	for i, j := 0, len(s)-1; i < j; i, j = i+1, j-1 {
		s[i], s[j] = s[j], s[i]
	}

	return s
}
