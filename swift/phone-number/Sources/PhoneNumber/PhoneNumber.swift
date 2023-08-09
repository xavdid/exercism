//Solution goes in Sources

class PhoneNumber: CustomStringConvertible {
  let number: String

  init(_ input: String) {
    var result = ""

    for c in input {
      if c.isNumber {
        result.append(c)
      }
    }

    if result.count != 10 {
      if result.count == 11 && result.prefix(1) == "1" {
        number = String(result.dropFirst())
      } else {
        number = String(repeating: "0", count: 10)
      }
    } else {
      number = result
    }
  }

  var areaCode: String {
    return String(number.prefix(3))
  }

  var description: String {
    // is this how all swift string indexing works??
    let startIndex = number.index(number.startIndex, offsetBy: 3)
    let endIndex = number.index(startIndex, offsetBy: 2)

    return "(\(areaCode)) \(number[startIndex...endIndex])-\(number.suffix(4))"
  }
}
