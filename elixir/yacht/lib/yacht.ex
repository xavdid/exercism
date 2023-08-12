defmodule Yacht do
  @type category ::
          :ones
          | :twos
          | :threes
          | :fours
          | :fives
          | :sixes
          | :full_house
          | :four_of_a_kind
          | :little_straight
          | :big_straight
          | :choice
          | :yacht

  defmacro count_case(dice, value) do
    quote do
      unquote(value) * Enum.count(unquote(dice), &(&1 == unquote(value)))
    end
  end

  @doc """
  Calculate the score of 5 dice using the given category's scoring method.
  """
  @spec score(category, dice :: [integer]) :: integer
  def score(category, dice) do
    case category do
      # these are syntax errors if uncommented
      # count_case(dice, :ones, 1)
      # count_case(dice, :twos, 2)

      :ones ->
        count_case(dice, 1)

      :twos ->
        count_case(dice, 2)

      :threes ->
        count_case(dice, 3)

      :fours ->
        count_case(dice, 4)

      :fives ->
        count_case(dice, 5)

      :sixes ->
        count_case(dice, 6)

      :full_house ->
        if Enum.frequencies(dice)
           |> Enum.map(fn {_, value} -> value end)
           |> Enum.sort() == [2, 3] do
          Enum.sum(dice)
        else
          0
        end

      :four_of_a_kind ->
        Enum.frequencies(dice)
        |> Enum.map(fn {d, value} ->
          if value >= 4 do
            d * min(value, 4)
          else
            0
          end
        end)
        |> Enum.sum()

      :little_straight ->
        if Enum.sort(dice) == [1, 2, 3, 4, 5] do
          30
        else
          0
        end

      :big_straight ->
        if Enum.sort(dice) == [2, 3, 4, 5, 6] do
          30
        else
          0
        end

      :choice ->
        Enum.sum(dice)

      :yacht ->
        if MapSet.new(dice) |> Enum.count() == 1 do
          50
        else
          0
        end
    end
  end
end
