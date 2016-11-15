defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: non_neg_integer
  def hamming_distance(a, a) do {:ok, 0} end
  def hamming_distance(a, b) when length(a) != length(b) do
    {:error, "Lists must be the same length"}
  end
  def hamming_distance(strand1, strand2) do
    count = List.zip([strand1, strand2]) |>
            Enum.map(&Tuple.to_list/1) |>
            Enum.filter(fn(list) ->
              Enum.fetch(list, 0) != Enum.fetch(list, 1)
            end) |>
            length
    {:ok, count}
  end
end
