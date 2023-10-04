class Matrix
  # @param raw_text [String]
  def initialize(raw_text)
    @matrix = raw_text.split("\n").map { |line| line.split(" ").map(&:to_i) }
  end

  def row(i)
    @matrix[i - 1]
  end

  def column(i)
    @matrix.map { |row| row[i - 1] }
  end
end
