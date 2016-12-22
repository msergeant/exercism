defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(numbers, key) do
    recursive_search(0, Tuple.to_list(numbers), key)
  end

  defp recursive_search(index, [key], key) do {:ok, index} end
  defp recursive_search(_, [key], _) do :not_found end
  defp recursive_search(_, [], _) do :not_found end
  defp recursive_search(index, numbers, key) do
    len = round(length(numbers) / 2)
    [left, right] = Enum.chunk(numbers, len, len, [])
    cond do
      List.first(right) == key -> {:ok, index + len}
      List.first(right) > key -> recursive_search(index, left, key)
      true -> recursive_search(index + len, right, key)
    end
  end
end
