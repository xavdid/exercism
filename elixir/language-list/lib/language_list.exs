defmodule LanguageList do
  @spec new :: []
  def new() do
    []
  end

  def add(list, language) do
    [language | list]
  end

  def remove(list) do
    [_ | tail] = list
    tail
  end

  def first(list) do
    hd(list)
  end

  def count(list) do
    length(list)
  end

  def functional_list?(list) do
    "Elixir" in list
  end
end

defmodule M do
  def half_even(i) when rem(i, 2) == 0 do
    i / 2
  end
end

# defmodule Greet do
#   def greet() do
#     IO.puts("hello!")
#   end

#   def greet(s) do
#     IO.puts("hello #{s}!")
#   end

#   # byte_size is similar enough to String.length, which isn't usable here for reasons
#   # https://stackoverflow.com/questions/34850121/why-forbidden-to-use-a-remote-function-inside-a-guard
#   def greet(s) when byte_size(s) < 5 do
#     IO.puts("yo #{s}")
#   end

#   def greet(s) do
#     IO.puts("hello #{s}!")
#   end

#   def greet(title, s) when s == "Kenobi" do
#     IO.puts("hello there, #{title} #{s}!")
#   end

#   def greet(title, s) do
#     IO.puts("howdy there, #{title} #{s}!")
#   end
# end

defmodule ListExample do
  def print([]), do: :ok

  def print([head | tail]) do
    IO.puts(head)
    print(tail)
  end
end

defmodule TuplePrinter do
  def passthrough do
    for n <- 0..5 do
      n * n
    end
  end

  def filter do
    for n <- 0..5, rem(n, 2) == 0 do
      n * n
    end
  end

  def filter2 do
    for n <- [0, 1, 4, 9, 16, 25], n > 0 do
      n / n
    end
  end

  def example do
    for {:good, n} <- [good: 1, good: 2, bad: 3, good: 4] do
      n * n
    end
  end

  # only square the middle numbers from 3-tuples
  def match do
    for {_, n, _} <- [{1, 2, 3}, {4, 5}, {6, 7, 8}, {9, 0}] do
      n * n
    end
  end

  def multiple do
    for i <- ["a", "b", "c"], j <- [1, 2] do
      {i, j}
    end
  end

  def assignment do
    for i <- ["a", "b", "c"], j <- [1, 2], k = j + 1 do
      {i, j, k}
    end
  end
end

defmodule Quicksort do
  def sort([]), do: []

  def sort([head | tail]) do
    sort(for x <- tail, x <= head, do: x) ++
      [head] ++
      sort(for x <- tail, x > head, do: x)
  end
end

defmodule Greet do
  def greet(name \\ "there"), do: "Hello #{name}"
end

# IO.inspect(Greet.greet())
# IO.inspect(Greet.greet("David"))
# IO.inspect(Greet.greet(name: "daddvid"))

defmodule Recursion do
  def print_multiple_times(_msg, 0) do
    :ok
  end

  def print_multiple_times(msg, n) do
    IO.puts(msg)
    print_multiple_times(msg, n - 1)
  end
end

Recursion.print_multiple_times("Hello!", 3)

# dirs = ['/home/mikey', '/home/james']

# for dir <- dirs,
#     file <- File.ls!(dir),
#     path = Path.join(dir, file),
#     File.regular?(path) do
#   File.stat!(path).size
# end

# IO.inspect(TuplePrinter.passthrough(), label: "passthrough")
# IO.inspect(TuplePrinter.filter(), label: "filter")
# IO.inspect(TuplePrinter.example(), label: "example")
# IO.inspect(TuplePrinter.match(), label: "match")
# IO.inspect(TuplePrinter.multiple(), label: "multliple")
# IO.inspect(TuplePrinter.assignment(), label: "assignment")

# IO.inspect(Quicksort.sort([5, 3, 1, 4, 9, 7, 6]))
