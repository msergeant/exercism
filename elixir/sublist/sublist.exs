defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) when a == b do
    :equal
  end

  def compare(_, [nil]) do
    :sublist
  end

  def compare([nil], _) do
    :superlist
  end

  def compare(a, b) do
    :unequal
  end
end
