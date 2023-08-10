// https://stackoverflow.com/a/56031985/1825390
func counter(_ s: String) -> [String: Int] {
  let letters = s.map { String($0) }
  var countedLetters = [String: Int]()
  letters.forEach { countedLetters[$0.lowercased(), default: 0] += 1 }
  return countedLetters
}

class Anagram {
  // Write your code for the 'Anagram' exercise in this file.
  let _word: String

  init(word: String) {
    _word = word
  }

  func match(_ words: [String]) -> [String] {
    let target = counter(_word)

    return words.filter({ word in
      let value = counter(word)
      // exact same counts and not the same word
      return value == target && word.lowercased() != _word.lowercased()
    })
  }
}
