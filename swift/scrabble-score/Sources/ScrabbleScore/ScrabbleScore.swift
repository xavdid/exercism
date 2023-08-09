//Solution goes in Sources

let pointValues: [Character: Int] = [
  "A": 1, "E": 1, "I": 1, "O": 1, "U": 1, "L": 1, "N": 1, "R": 1, "S": 1, "T": 1,
  "D": 2, "G": 2,
  "B": 3, "C": 3, "M": 3, "P": 3,
  "F": 4, "H": 4, "V": 4, "W": 4, "Y": 4,
  "K": 5,
  "J": 8, "X": 8,
  "Q": 10, "Z": 10,
]

class Scrabble {
  let word: String

  init(_ _word: String?) {
    word = _word?.uppercased() ?? ""  // can't trim this??
  }

  var score: Int {
    word.reduce(0, { acc, c in acc + (pointValues[c] ?? 0) })
  }

  static func score(_ word: String) -> Int {
    return Scrabble(word).score
  }
}
