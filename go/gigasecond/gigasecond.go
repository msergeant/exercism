// Package gigasecond finds 1 billion seconds after the given time
package gigasecond

import "time"

const testVersion = 4
const billion = 1e9

// AddGigasecond returns the time 1 billion seconds later
func AddGigasecond(t time.Time) time.Time {
	return t.Add(billion * time.Second)
}
