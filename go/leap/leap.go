// Package leap provides function for finding leap years
package leap

const testVersion = 3

// IsLeapYear returns true for leap years, false for non-leap years
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
