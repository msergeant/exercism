defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, a), do: :equal
  def compare(_, [nil]), do: :sublist
  def compare([nil], _), do: :superlist

  def compare(a, b) do
    cond do
      recursive_compare(a, b) -> :sublist
      recursive_compare(b, a) -> :superlist
      true-> :unequal
    end
  end

  defp recursive_compare([], candidate_element, [candidate_element | _]), do: true
  defp recursive_compare([x], x, [x]), do: true
  defp recursive_compare([x], x, [x | _]), do: true

  defp recursive_compare([matching_first_element | remaining_candidates], matching_first_element, [matching_first_element | remaining_elements]) do
    [new_candidate | _ ] = remaining_candidates
    recursive_compare(remaining_candidates, new_candidate, remaining_elements)
  end

  defp recursive_compare(_, _, _), do: false

  defp recursive_compare(a, b) do
    Enum.reduce_while(b, b,  fn (_, acc) ->
      [first_of_a | rest_of_a] = a
      [first_of_b | rest_of_b] = acc
      cond do
        recursive_compare(a, first_of_a, acc) -> {:halt, acc}
        true -> {:cont, rest_of_b}
      end
    end) |> Enum.count > 0
  end
end
