class Bst
  attr_reader :data

  attr_accessor :left
  attr_accessor :right

  # @param value [Integer]
  def initialize(value)
    @data = value
  end

  # @param value [Integer]
  def insert(value)
    target = value <= @data ? :left : :right

    if self.send(target).nil?
      self.send("#{target}=", Bst.new(value))
    else
      self.send(target).insert(value)
    end
  end

  def each(&block)
    if block_given?
      @left.each &block unless @left.nil?
      block.call(@data)
      @right.each &block unless @right.nil?
    else
      to_enum(:each)
    end
  end
end
