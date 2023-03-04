package isogram

import (
	"unicode"
)

func IsIsogram(word string) bool {
	set := make(map[rune]int)

	for _, c := range word {
		if c == ' ' || c == '-' {
			continue
		}

		c = unicode.ToLower(c)
		if _, ok := set[c]; ok {
			return false
		}
		set[c] = 1
	}

	return true
}
