class RLE {
  static encode(s) {
    var result = ""
    var CurrChar = ""
    var CurrCount = 0

    for (c in s) {
      if (c == CurrChar) {
        CurrCount = CurrCount + 1
      } else {
        result = result + "%(CurrCount > 1 ? CurrCount : "")%(CurrChar)"
        CurrChar = c
        CurrCount = 1
      }
    }
    result = result + "%(CurrCount > 1 ? CurrCount : "")%(CurrChar)"

    return result
  }
  static decode(s) {
    var result = ""

    var CurNum = "" // running total of the current multi-digit number
    for (c in s) {
      // empty string parses like a number??
      if (Num.fromString(c) && c != " ") {
        CurNum = CurNum + c // join digit
      } else {
        result = result + c * (Num.fromString(CurNum) || 1)
        CurNum = ""
      }
    }

    return result
  }
}
