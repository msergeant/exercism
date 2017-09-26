// Package accumulate implements the functional accumulate operation
package accumulate

const testVersion = 1

// Accumulate returns the result of calling operator on each member of inList
func Accumulate(inList []string, operator func(string) string) []string {
	var result []string
	for _, s := range inList {
		result = append(result, operator(s))
	}
	return result
}
