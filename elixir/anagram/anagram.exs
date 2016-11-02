defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
    Enum.filter(candidates, fn(word) -> anagram_compare(base, word) end)
  end

  defp anagram_compare(a, b) do
    String.downcase(a) != String.downcase(b) &&
    letter_summary(a) == letter_summary(b)
  end

  defp letter_summary(word) do
    word
    |> String.downcase
    |> String.to_char_list
    |> Enum.sort
  end
end
