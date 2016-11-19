defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count(l) do
    Enum.reduce(l, 0, fn(_, acc) -> acc + 1 end)
  end

  @spec reverse(list) :: list
  def reverse(l) do
    Enum.reduce(l, [], fn(i, acc) -> [i | acc] end)
  end

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    Enum.reduce(l, [], fn(i, acc) -> [f.(i) | acc] end)
    |> reverse
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    Enum.reduce(l, [], fn(i, acc) ->
      cond do
        f.(i) -> [i | acc]
        true -> acc
      end
    end)
    |> reverse
  end

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce([], acc, _) do acc end
  def reduce([first | l], acc, f) do
    reduce(l, f.(first, acc), f)
  end

  @spec append(list, list) :: list
  def append(a, b) do
    a ++ b
  end

  @spec concat([[any]]) :: [any]
  def concat(ll) do
    List.flatten(ll)
  end
end
