defmodule Lasagna do
  # Please define the 'expected_minutes_in_oven/0' function
  @spec expected_minutes_in_oven :: 40
  def expected_minutes_in_oven do
    40
  end

  # Please define the 'remaining_minutes_in_oven/1' function
  @spec remaining_minutes_in_oven(number) :: number
  def remaining_minutes_in_oven(m) do
    expected_minutes_in_oven() - m
  end

  # Please define the 'preparation_time_in_minutes/1' function
  @spec preparation_time_in_minutes(number) :: number
  def preparation_time_in_minutes(m) do
    m * 2
  end

  # Please define the 'total_time_in_minutes/2' function
  @spec total_time_in_minutes(number, number) :: number
  def total_time_in_minutes(num_layers, min) do
    min + preparation_time_in_minutes(num_layers)
  end

  # Please define the 'alarm/0' function
  def alarm() do
    "Ding!"
  end
end
