package pangram

import (
	"strings"
	"unicode"
)

func IsPangram(input string) bool {
	found := map[rune]bool{}

	for _, c := range strings.ToLower(input) {
		if !unicode.IsLetter(c) {
			continue
		}
		found[c] = true
	}

	return len(found) == 26
}
