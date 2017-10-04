// Package house constructs a children's song using recursion
package house

import (
	"strings"
)

const testVersion = 1

var verseText = []struct {
	object string
	action string
}{
	{"malt", "ate"},
	{"rat", "killed"},
	{"cat", "worried"},
	{"dog", "tossed"},
	{"cow with the crumpled horn", "milked"},
	{"maiden all forlorn", "kissed"},
	{"man all tattered and torn", "married"},
	{"priest all shaven and shorn", "woke"},
	{"rooster that crowed in the morn", "kept"},
	{"farmer sowing his corn", "belonged to"},
	{"horse and the hound and the horn", ""},
}

// Verse returns an individual verse of the song
func Verse(n int) (output string) {
	if n == 1 {
		output = "This is the house that Jack built."
		return
	}
	verse := verseText[n-2]

	output += "This is the " + verse.object + "\n"
	output += recursiveVerse(n - 2)
	return
}

// Song returns a concatenated string of every verse
func Song() (output string) {
	for i := 1; i < 13; i++ {
		output += Verse(i) + "\n\n"
	}
	output = strings.TrimRight(output, "\n")

	return
}

func recursiveVerse(n int) (output string) {
	if n == 0 {
		output = "that lay in the house that Jack built."
		return
	}

	verse := verseText[n-1]
	output = "that " + verse.action + " the " + verse.object + "\n"
	output += recursiveVerse(n - 1)
	return
}
