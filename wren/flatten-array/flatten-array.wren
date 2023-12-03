class Flatten {
  static flatten(list) {
    var result = []

    for (e in list) {
      if (e == null) {
        continue
      }
      if (e is Sequence) {
        result.addAll(Flatten.flatten(e))
      } else {
        result.add(e)
      }
    }

    return result
  }
}
