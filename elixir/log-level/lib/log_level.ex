defmodule LogLevel do
  @spec to_label(number, boolean) ::
          :debug | :error | :fatal | :info | :trace | :unknown | :warning
  def to_label(level, legacy?) do
    cond do
      level === 0 -> if legacy?, do: :unknown, else: :trace
      level === 1 -> :debug
      level === 2 -> :info
      level === 3 -> :warning
      level === 4 -> :error
      level === 5 -> if legacy?, do: :unknown, else: :fatal
      true -> :unknown
    end
  end

  @spec alert_recipient(number, boolean) :: :dev1 | :dev2 | :ops | false
  def alert_recipient(level, legacy?) do
    label = to_label(level, legacy?)

    cond do
      label in [:error, :fatal] ->
        :ops

      label in [:unknown] ->
        cond do
          legacy? -> :dev1
          true -> :dev2
        end

      true ->
        false
    end
  end
end
