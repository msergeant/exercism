defmodule Luhn do
  @doc """
  Calculates the total checksum of a number
  """
  @spec checksum(String.t()) :: integer
  def checksum(number) do
    number
    |> String.graphemes
    |> double_even_digits
    |> Enum.sum
  end

  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(number) do
    rem(checksum(number), 10) == 0
  end

  @doc """
  Creates a valid number by adding the correct
  checksum digit to the end of the number
  """
  @spec create(String.t()) :: String.t()
  def create(number) do
    plug = rem((10 - rem(checksum(number <> "0"), 10)), 10) |> to_string

    number <> plug
  end

  defp double_even_digits(digits) do
    digits
    |> Enum.map(&String.to_integer/1)
    |> Enum.reverse
    |> Enum.with_index
    |> Enum.reduce([], fn({n, index}, acc) ->
      [digit_doubler(n, index) | acc]
    end)
  end

  defp digit_doubler(n, index) when rem(index, 2) == 1 and n > 4 do n * 2 - 9 end
  defp digit_doubler(n, index) when rem(index, 2) == 1 do n * 2 end
  defp digit_doubler(n, _) do n end
end
