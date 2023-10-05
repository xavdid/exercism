class CircularBuffer
  class BufferEmptyException < Exception
  end
  class BufferFullException < Exception
  end

  def initialize(max_size)
    @max_size = max_size
    clear
  end

  def read
    raise BufferEmptyException if @data.empty?
    @data.shift
  end

  def write(item)
    raise BufferFullException if @data.size == @max_size
    @data.push(item)
  end

  def write!(item)
    read if @data.size == @max_size
    @data.push(item)
  end

  def clear
    @data = []
  end
end
