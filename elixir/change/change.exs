defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns :error if it is not possible to compute the right amount of coins.
    Otherwise returns the tuple {:ok, map_of_coins}

    ## Examples

      iex> Change.generate(3, [5, 10, 15])
      :error

      iex> Change.generate(18, [1, 5, 10])
      {:ok, %{1 => 3, 5 => 1, 10 => 1}}

  """

  @spec generate(integer, list) :: {:ok, map} | :error
  def generate(amount, values) do
    _generate({:ok, %{}}, amount, values |> Enum.sort |> Enum.reverse)
  end

  defp _generate({:ok, acc}, amount, []) when amount > 0 do :error end
  defp _generate({:ok, acc}, amount, []) do {:ok, acc} end
  defp _generate({:ok, acc}, amount, [h | t]) do
    div = div(amount, h)
    test_result = _generate({:ok, Map.merge(acc, %{h => div})}, amount - div * h, t)
    cond do
      test_result == :error or div == 0 -> _generate({:ok, Map.merge(acc, %{h => 0})}, amount, t)
      true -> test_result
    end
  end
end
