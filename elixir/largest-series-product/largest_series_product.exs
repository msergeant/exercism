defmodule Series do

  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t, non_neg_integer) :: non_neg_integer
  def largest_product(_, 0) do 1 end
  def largest_product(number_string, size) when size > 0 do
    cond do
      String.length(number_string) < size -> raise ArgumentError
      true -> number_string
              |> String.graphemes
              |> Enum.map(&String.to_integer/1)
              |> Enum.chunk(size, 1, [0])
              |> Enum.map(&product_of_list/1)
              |> Enum.max
    end
  end
  def largest_product(_, _) do raise ArgumentError end

  defp product_of_list(list) do
    list
    |> Enum.reduce(1, &(&1 * &2))
  end
end
