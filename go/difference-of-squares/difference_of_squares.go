// Package diffsquares provide functions for finding the
// sum of squares and the square of sums
package diffsquares

const testVersion = 1

// SumOfSquares returns the result of adding the squares of all the
// numbers leading up to n
func SumOfSquares(n int) int {
	result := 0
	for i := n; i > 0; i-- {
		result += i * i
	}
	return result
}

// SquareOfSums returns the result of adding up the numbers leading
// up to n and then squaring the result
func SquareOfSums(n int) int {
	result := 0
	for i := n; i > 0; i-- {
		result += i
	}
	return result * result
}

// Difference returns the difference between calling SquareOfSums and
// SumOfSquares
func Difference(n int) int {
	return SquareOfSums(n) - SumOfSquares(n)
}
