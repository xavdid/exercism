package binarysearch

func SearchInts(list []int, target int) int {
	low := 0
	hi := len(list) - 1

	for low <= hi {
		index := (low + hi) / 2
		val := list[index]

		if val == target {
			return index
		}

		if val > target {
			hi = index - 1
		} else {
			low = index + 1
		}
	}

	return -1
}
