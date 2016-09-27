defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t
  def convert(number) do
    out_string = check_pling.("", number)
    |> check_plang.(number)
    |> check_plong.(number)

    cond do
      String.length(out_string) > 0 -> out_string
      true -> Integer.to_string(number)
    end
  end

  defp raindrop_generator(divisor, output) do
    fn(string, number) ->
      cond do
        rem(number, divisor) == 0 -> string <> output
        true -> string
      end
    end
  end

  defp check_pling do
    raindrop_generator(3, "Pling")
  end

  defp check_plang do
    raindrop_generator(5, "Plang")
  end

  defp check_plong do
    raindrop_generator(7, "Plong")
  end
end
