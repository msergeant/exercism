defmodule Roman do
  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t
  def numerals(number) do
    [
      thousands.(number),
      hundreds.(number),
      tens.(number),
      ones.(number)
    ] |> Enum.join
  end

  defp digit_generator(units, units5, units10, power) do
    fn(number) ->
      digit_we_care_about = div(rem(number, :math.pow(10, power) |> round), :math.pow(10, power - 1) |> round)
      cond do
        digit_we_care_about == 0 -> ""
        digit_we_care_about < 4 -> (1..digit_we_care_about) |> Enum.reduce("", fn(_, acc) -> acc <> units end)
        digit_we_care_about == 4 -> units <> units5
        digit_we_care_about == 5 -> units5
        digit_we_care_about < 9 -> (6..digit_we_care_about) |> Enum.reduce(units5, fn(_, acc) -> acc <> units end)
        digit_we_care_about == 9 -> units <> units10
        true -> ""
      end
    end
  end

  defp ones do
    digit_generator("I", "V", "X", 1)
  end

  defp tens do
    digit_generator("X", "L", "C", 2)
  end

  defp hundreds do
    digit_generator("C", "D", "M", 3)
  end

  defp thousands do
    digit_generator("M", "", "", 4)
  end
end
