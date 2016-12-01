defmodule Binary do
  @doc """
  Convert a string containing a binary number to an integer.

  On errors returns 0.
  """
  @spec to_decimal(String.t) :: non_neg_integer
  def to_decimal(string) do
    try do
      string
      |> String.graphemes
      |> Enum.map(&String.to_integer/1)
      |> Enum.reverse
      |> Enum.with_index
      |> Enum.reduce(0, &add_function/2)
    rescue
      ArgumentError -> 0
    end
  end

  defp add_function({n, index}, acc) when n == 0 or n == 1 do
    acc + (n * :math.pow(2, index)) |> round
  end
  defp add_function(_, _) do raise ArgumentError end
end
