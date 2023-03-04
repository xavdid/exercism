package sieve

import (
	"sort"
)

func Sieve(limit int) []int {
	potentialPrimes := make(map[int]bool, limit+1)

	// declare map
	for i := 2; i <= limit; i++ {
		potentialPrimes[i] = true
	}

	// for each number that is marked as prime, make false its multiples (starting w/ 2)
	for j := 2; j < limit; j++ {
		for m := 2; m*j <= limit; m++ {
			potentialPrimes[m*j] = false
		}
	}

	// iterate over the map and keep any items that are still true
	result := []int{}
	for k, v := range potentialPrimes {
		if !v {
			continue
		}
		result = append(result, k)
	}

	sort.Ints(result)
	return result
}
