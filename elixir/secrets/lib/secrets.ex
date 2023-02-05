defmodule Secrets do
  defp make_func(func, secret) do
    &func.(&1, secret)
  end

  @spec secret_add(number) :: (number -> number)
  def secret_add(secret) do
    # this works, but doesn't actually save me much in the way of space
    make_func(&Kernel.+/2, secret)
  end

  @spec secret_subtract(number) :: (number -> number)
  def secret_subtract(secret) do
    &(&1 - secret)
  end

  @spec secret_multiply(number) :: (number -> number)
  def secret_multiply(secret) do
    &(&1 * secret)
  end

  @spec secret_divide(number) :: (number -> number)
  def secret_divide(secret) do
    &floor(&1 / secret)
  end

  @spec secret_and(number) :: (number -> number)
  def secret_and(secret) do
    &Bitwise.band(&1, secret)
  end

  @spec secret_xor(number) :: (integer -> integer)
  def secret_xor(secret) do
    &Bitwise.bxor(&1, secret)
  end

  @spec secret_combine((integer -> integer), (integer -> integer)) :: (integer -> integer)
  def secret_combine(secret_function1, secret_function2) do
    &secret_function2.(secret_function1.(&1))
    # or:
    # &(secret_function1.(&1) |> secret_function2.())
  end
end
