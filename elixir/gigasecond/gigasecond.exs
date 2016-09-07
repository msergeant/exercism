defmodule Gigasecond do
  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) :: :calendar.datetime

  def from({{year, month, day}, {hours, minutes, seconds}}) do
    :calendar.datetime_to_gregorian_seconds({{year, month, day}, {hours, minutes, seconds}})
    |> add_gigasecond()
    |> :calendar.gregorian_seconds_to_datetime()
  end

  defp add_gigasecond(x) do
    x + 1000000000
  end
end
