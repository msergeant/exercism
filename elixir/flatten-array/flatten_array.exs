defmodule FlattenArray do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1,2,3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """

  @spec flatten(list) :: list
  def flatten(list) do
    _flatten(list, [])
  end

  defp _flatten([], list) do list end
  defp _flatten([h | t], list) when is_nil h do _flatten(t, list) end
  defp _flatten([h | t], list) when is_list h do
    cond do
      Enum.empty? h -> _flatten(t, list)
      true -> _flatten(t, list ++ _flatten(h, []))
    end
  end
  defp _flatten([h | t], list) do _flatten(t, list ++ [h]) end
end
