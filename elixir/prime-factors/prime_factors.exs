defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number) do
    recursive_factors(number, 2)
  end
  defp recursive_factors(num, _) when num == 1 do [] end
  defp recursive_factors(num, _) when num < 4 do [num] end
  defp recursive_factors(num, 2) do
    cond do
      rem(num, 2) == 0 -> [2 | recursive_factors(div(num, 2), 2)]
      true -> recursive_factors(num, 3)
    end
  end
  defp recursive_factors(num, next) do
    cond do
      rem(num, next) == 0 -> [next | recursive_factors(div(num,next), 3)]
      true -> recursive_factors(num, next + 2)
    end
  end
end
