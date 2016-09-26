defmodule Accumulate do
  @doc """
    Given a list and a function, apply the function to each list item and
    replace it with the function's return value.

    Returns a list.

    ## Examples

      iex> Accumulate.accumulate([], fn(x) -> x * 2 end)
      []

      iex> Accumulate.accumulate([1, 2, 3], fn(x) -> x * 2 end)
      [2, 4, 6]

  """

  @spec accumulate(list, (any -> any)) :: list
  def accumulate(list, fun) do
    recursive_accumulate(list, [], fun)
  end

  defp recursive_accumulate([], partial_list, _) do
    partial_list
  end

  defp recursive_accumulate(list, partial_list, fun) do
    recursive_accumulate(tl(list), partial_list ++ [fun.(hd(list))], fun)
  end
end
