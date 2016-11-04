defmodule Prime do

  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(1) do 2 end
  def nth(count) when count > 0 do
    find_nth_prime(count, 3, [2])
  end

  defp find_nth_prime(n, test, primes) do
    cond do
      length(primes) == n -> List.last(primes)
      Enum.any?(primes, fn(x) -> rem(test, x) == 0 end) -> find_nth_prime(n, test + 2, primes)
      true -> find_nth_prime(n, test + 2, primes ++ [test])
    end
  end

end
