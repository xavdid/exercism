def pad(i)
  i.to_s.rjust(2, "0")
end

class Clock
  attr_reader :hour
  attr_reader :minute

  def initialize(hour: 0, minute: 0)
    @hour = (hour + minute / 60) % 24
    @minute = minute % 60
  end

  def to_s
    "#{pad(@hour)}:#{pad(@minute)}"
  end

  def combine(other, operation)
    Clock.new(
      hour: @hour.send(operation, other.hour),
      minute: @minute.send(operation, other.minute)
    )
  end

  # @param other [Clock]
  def +(other)
    combine(other, :+)
  end

  # @param other [Clock]
  def -(other)
    combine(other, :-)
  end

  # @param other [Clock]
  def ==(other)
    @hour == other.hour && @minute == other.minute
  end
end
