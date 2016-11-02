defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(1, _) do
    0
  end

  def to(limit, factors) do
    Enum.to_list(1..limit - 1)
    |> Enum.filter(fn num -> divisible_by_any(num, factors) end)
    |> Enum.reduce(0, fn(a, b) -> a + b end)
  end

  defp divisible_by_any(1, _) do
    false
  end

  defp divisible_by_any(divisor, factors) do
    Enum.find(factors, fn num -> rem(divisor, num) == 0 end)
  end
end
