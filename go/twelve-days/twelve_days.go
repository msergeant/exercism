// Package twelve outputs the lyrics to the 12 days of christmas
package twelve

import (
	"strings"
)

const testVersion = 1

var dayData = [][]string{
	{"zeroth", ""},
	{"first", "a Partridge in a Pear Tree."},
	{"second", "two Turtle Doves"},
	{"third", "three French Hens"},
	{"fourth", "four Calling Birds"},
	{"fifth", "five Gold Rings"},
	{"sixth", "six Geese-a-Laying"},
	{"seventh", "seven Swans-a-Swimming"},
	{"eighth", "eight Maids-a-Milking"},
	{"ninth", "nine Ladies Dancing"},
	{"tenth", "ten Lords-a-Leaping"},
	{"eleventh", "eleven Pipers Piping"},
	{"twelfth", "twelve Drummers Drumming"},
}

// Song returns the full 12 days of Christmas song
func Song() string {
	var fullSong []string
	for i := 1; i < len(dayData); i++ {
		fullSong = append(fullSong, Verse(i))
	}
	fullSong = append(fullSong, "")

	return strings.Join(fullSong, "\n")
}

// Verse returns the requested verse
func Verse(n int) string {
	v := []string{"On the " + dayData[n][0] + " day of Christmas my true love gave to me, "}
	if n > 1 {
		v = append(v, theRest(n))
		v = append(v, ", and ")
	}
	v = append(v, dayData[1][1])
	return strings.Join(v, "")
}

func theRest(n int) string {
	var rest []string

	for i := n; i > 1; i-- {
		rest = append(rest, dayData[i][1])
	}

	return strings.Join(rest, ", ")
}
