OFFSET = "a".ord # index of a letter in the lowercase alphabet
ALPHABET = ("a".."z").to_a

# @param c [String]
def convert(c)
  c.ord - OFFSET
end

class Cipher
  attr_reader :key

  def initialize(key = "d" * 10)
    raise ArgumentError unless key.match?(/\A[a-z]+\z/)
    @key = key
  end

  # @param plaintext [String]
  def encode(plaintext)
    plaintext
      .chars
      .each_with_index
      .map { |c, i| ALPHABET[(convert(c) + convert(@key[i])) % ALPHABET.size] }
      .join
  end

  # @param ciphertext [String]
  def decode(ciphertext)
    ciphertext
      .chars
      .each_with_index
      .map { |c, i| ALPHABET[c.ord - @key[i].ord] }
      .join
  end
end
