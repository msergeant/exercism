// Package summultiples provides functions for finding sums of multiples
package summultiples

const testVersion = 2

// SumMultiples returns the sum of all the multiples of the divisors up to the limit
func SumMultiples(limit int, divisors ...int) (sum int) {
	for i := 1; i < limit; i++ {
		for _, element := range divisors {
			if i%element == 0 {
				sum += i
				break
			}
		}
	}
	return
}
