// Define the 'Nucleotide' enum, its `init`, and its `complementOfDNA` method

let pairs: [Character: String] = ["G": "C", "C": "G", "T": "A", "A": "U"]

enum TranscriptionError: Error {
  case invalidNucleotide(String)
}

class Nucleotide {
  var value: String
  init(_ value: String) {
    self.value = value
  }

  func complementOfDNA() throws -> String {
    var result: [String] = []

    for c in self.value {
      if let opp = pairs[c] {
        result.append(opp)
      } else {
        throw TranscriptionError.invalidNucleotide("\(c) is not a valid Nucleotide")
      }
    }

    return result.joined()
  }
}
