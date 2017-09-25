// Package used to find whether a given year is a leap year
package leap

const testVersion = 3

// returns true if year is a leap year
// returns false if year is not a leap year
func IsLeapYear(y int) bool {
	switch {
	case y%4 != 0:
		return false
	case y%400 == 0:
		return true
	case y%100 == 0:
		return false
	default:
		return true
	}
}
