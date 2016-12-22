defmodule Sieve do

  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit) do
    primes = 0..limit  |> Enum.map(fn(_)-> true end)
    mark_non_primes(limit, 2, primes)
    |> Enum.with_index
    |> Enum.filter(fn({is_prime, index}) -> index > 1 && is_prime end)
    |> Enum.map(fn({_, index}) -> index end)
  end

  defp mark_non_primes(limit, index, primes) do
    is_prime = Enum.fetch!(primes, index)
    cond do
      index == limit - 1 -> primes
      false -> mark_non_primes(limit, index + 1, primes)
      true  -> mark_non_primes(limit, index + 1, do_sieve(index, limit, primes))
    end
  end

  defp do_sieve(index, limit, primes) do
    index..limit
    |> Enum.filter(fn(i) -> i > index && rem(i,index) == 0 end)
    |> Enum.reduce(primes, fn(i,acc) ->
      List.update_at(acc, i, fn(_) -> false end)
    end)
  end
end
