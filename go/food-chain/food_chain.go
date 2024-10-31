package foodchain

import (
	"fmt"
	"strings"
)

const wriggle = "wriggled and jiggled and tickled inside her"

var animals = []struct{ name, result string }{
	{"", ""},
	{"fly", "I don't know why she swallowed the fly. Perhaps she'll die."},
	{"spider", fmt.Sprintf("It %s.", wriggle)},
	{"bird", "How absurd to swallow a bird!"},
	{"cat", "Imagine that, to swallow a cat!"},
	{"dog", "What a hog, to swallow a dog!"},
	{"goat", "Just opened her throat and swallowed a goat!"},
	{"cow", "I don't know how she swallowed a cow!"},
	{"horse", "She's dead, of course!"},
}

func conditional_wiggle(v int) string {
	if v == 3 {
		return fmt.Sprintf(" that %s", wriggle)
	}
	return ""
}

func Verse(v int) string {
	res := []string{fmt.Sprintf("I know an old lady who swallowed a %s.", animals[v].name), animals[v].result}

	if 1 < v && v < 8 {
		for ; v > 1; v-- {
			res = append(res, fmt.Sprintf("She swallowed the %s to catch the %s%s.", animals[v].name, animals[v-1].name, conditional_wiggle(v)))
		}
		// perhaps she'll die
		res = append(res, animals[1].result)
	}

	return strings.Join(res, "\n")
}

func Verses(start, end int) string {
	res := []string{}
	for i := start; i <= end; i++ {
		res = append(res, Verse(i))
	}
	return strings.Join(res, "\n\n")
}

func Song() string {
	return Verses(1, 8)
}
