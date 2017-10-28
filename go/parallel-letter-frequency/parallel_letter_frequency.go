// Package letter provides functions for counting letter frequencies of strings
package letter

const testVersion = 1

// ConcurrentFrequency returns the total letter frequencies for the input strings
func ConcurrentFrequency(stringList []string) FreqMap {
	m := FreqMap{}
	c := make(chan FreqMap)

	for _, str := range stringList {
		go func(s string, ch chan FreqMap) {
			ch <- Frequency(s)
		}(str, c)
	}

	for range stringList {
		fm := <-c

		for k, v := range fm {
			m[k] += v
		}
	}

	return m
}
