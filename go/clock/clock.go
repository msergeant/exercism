// Package clock provides functionality for displaying clock time
package clock

import "fmt"

const testVersion = 4

// You can find more details and hints in the test file.

//Clock represents the hour and minute of a clock time
type Clock struct {
	hour   int
	minute int
}

// New constructs a clock time
func New(hour, minute int) Clock {
	for minute < 0 {
		hour -= 1
		minute += 60
	}
	for minute >= 60 {
		hour += 1
		minute -= 60
	}
	for hour < 0 {
		hour += 24
	}
	return Clock{hour: hour % 24, minute: minute % 60}
}

// String returns "00:00" formatted clock time
func (c Clock) String() string {
	return fmt.Sprintf("%02d:%02d", c.hour, c.minute)
}

// Add returns a new Clock by adding minutes to the old clock
func (c Clock) Add(minutes int) Clock {
	return New(c.hour, c.minute+minutes)
}
