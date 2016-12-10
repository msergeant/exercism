defmodule Hexadecimal do
  @doc """
    Accept a string representing a hexadecimal value and returns the
    corresponding decimal value.
    It returns the integer 0 if the hexadecimal is invalid.
    Otherwise returns an integer representing the decimal value.

    ## Examples

      iex> Hexadecimal.to_decimal("invalid")
      0

      iex> Hexadecimal.to_decimal("af")
      175

  """

  @spec to_decimal(binary) :: integer
  def to_decimal(hex) do
    try do
      hex
      |> String.downcase
      |> String.graphemes
      |> Enum.map(&char_to_integer/1)
      |> Enum.reverse
      |> Enum.with_index
      |> Enum.reduce(0, &add_function/2)
    rescue
      ArgumentError -> 0
    end
  end

  defp add_function({n, index}, acc) when n < 16 do
    acc + (n * :math.pow(16, index)) |> round
  end
  defp add_function(_, _) do raise ArgumentError end

  defp char_to_integer(char) when char >= "a" and char <= "f" do
    (char
    |> String.to_char_list
    |> List.first) - ?a + 10
  end
  defp char_to_integer(char), do: String.to_integer(char)
end
