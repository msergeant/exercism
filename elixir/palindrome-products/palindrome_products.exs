defmodule Palindromes do

  @doc """
  Generates all palindrome products from an optionally given min factor (or 1) to a given max factor.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: map
  def generate(max_factor, min_factor \\ 1) do
    for( a <- min_factor..max_factor,
         b <- a..max_factor,
         is_palindrome?(a*b),
         do: [a, b] )
     |> Enum.reduce(%{}, fn([a,b], acc) ->
       old_list = acc[a*b]

       cond do
         old_list == nil -> Map.put(acc, a * b, [[a, b]])
         true -> Map.put(acc, a * b, old_list ++ [[a,b]])
       end
     end)
  end

  defp is_palindrome?(num) when num < 10 do true end
  defp is_palindrome?(num) do
    num_str = num |> to_string
    num_str == String.reverse(num_str)
  end
end
