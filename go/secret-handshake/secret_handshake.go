package secret

import "fmt"

func Handshake(code uint) []string {
	padded := fmt.Sprintf("%05b", code)

	result := []string{}

	if padded[4] == '1' {
		result = append(result, "wink")
	}
	if padded[3] == '1' {
		result = append(result, "double blink")
	}
	if padded[2] == '1' {
		result = append(result, "close your eyes")
	}
	if padded[1] == '1' {
		result = append(result, "jump")
	}
	if padded[0] == '1' {
		// reverse the slice; built-in macro
		for i, j := 0, len(result)-1; i < j; i, j = i+1, j-1 {
			result[i], result[j] = result[j], result[i]
		}
	}

	return result
}
