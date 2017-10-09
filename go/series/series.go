// Package series provides methods for returning substrings of adjacent numerals
package series

const testVersion = 2

// All returns all the substrings of the requested length
func All(n int, str string) (output []string) {
	for i := 0; (i + n) < len(str)+1; i++ {
		output = append(output, str[i:i+n])
	}
	return
}

// UnsafeFirst attempts to return a string of length n without checking if it is valid
func UnsafeFirst(n int, str string) (output string) {
	output = str[0:n]
	return
}

// First checks to make sure the requested string length is valid before returning
func First(n int, str string) (output string, ok bool) {
	if n > len(str) {
		return
	}
	ok = true
	output = str[0:n]
	return
}
