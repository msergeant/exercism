defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a NucleotideCount strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) do
    if not(Enum.member?(@nucleotides, nucleotide)) do
      raise ArgumentError
    end

    Enum.reduce(strand, 0, fn(x, acc) ->
        cond do
          not(Enum.member?(@nucleotides, x)) -> raise ArgumentError
          x == nucleotide -> acc + 1
          true -> acc
        end
    end)
  end


  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand) do
    Enum.reduce(@nucleotides, %{}, fn(x, acc) ->
      Map.put(acc, x, count(strand, x))
    end)
  end
end
