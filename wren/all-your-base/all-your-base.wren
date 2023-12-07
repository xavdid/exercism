class AllYourBase {
  static rebase(inputBase, digits, outputBase) {
    if (inputBase < 2) {
      Fiber.abort("input base must be >= 2")
    }
    if (outputBase < 2) {
      Fiber.abort("output base must be >= 2")
    }
    digits.each { |d|
      if (!(0 <= d && d < inputBase)) {
        Fiber.abort("all digits must satisfy 0 <= d < input base")
      }
    }


    // convert to a base-10 number
    var num = digits.reduce(0) { |res, i| (res * inputBase) + i }

    var result = []
    while (num > 0) {
      result.add(num % outputBase)
      num = (num / outputBase).floor
    }

    return result.count > 0 ? result[-1..0] : [0]
  }
}
