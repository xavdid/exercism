defmodule FreelancerRates do
  @spec daily_rate(number) :: float
  def daily_rate(hourly_rate) do
    hourly_rate * 8.0
  end

  @spec apply_discount(number, float) :: float
  def apply_discount(before_discount, discount) do
    before_discount * (100 - discount) / 100.0
  end

  @spec monthly_rate(number, float) :: integer
  def monthly_rate(hourly_rate, discount) do
    daily_rate(hourly_rate)
    |> apply_discount(discount)
    |> Kernel.*(22)
    |> ceil
  end

  def days_in_budget(budget, hourly_rate, discount) do
    (budget / (daily_rate(hourly_rate) |> apply_discount(discount))) |> Float.floor(1)
  end
end
