defmodule CollatzConjecture do
  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  def calc(1), do: 0

  def calc(i) when i > 0 and rem(i, 2) == 0 do
    1 + calc(floor(i / 2))
  end

  def calc(i) when rem(i, 2) == 1 do
    1 + calc(3 * i + 1)
  end
end
