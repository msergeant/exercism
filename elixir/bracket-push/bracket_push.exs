defmodule BracketPush do
  @brackets %{ "{": "}", "[": "]", "(": ")" }

  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t) :: boolean
  def check_brackets(str) do
    (str
    |> String.graphemes
    |> Enum.reduce([], &build_stack/2)
    |> length) == 0
  end

  defp build_stack x, acc do
    cond do
      is_opening_bracket?(x) -> List.insert_at(acc, 0, x)
      is_proper_closing_bracket?(acc, x) -> List.delete_at(acc, 0)
      is_closing_bracket?(x) -> List.insert_at(acc, 0, x)
      true -> acc
    end
  end

  defp is_opening_bracket? char do
    Map.keys(@brackets)
    |> Enum.map(&Atom.to_string/1)
    |> Enum.member?(char)
  end

  defp is_closing_bracket? char do
    Map.values(@brackets)
    |> Enum.member?(char)
  end

  defp is_proper_closing_bracket? [], _ do false end
  defp is_proper_closing_bracket? list, char do
    test_char = List.first(list) |> String.to_atom
    char == Map.get(@brackets, test_char)
  end
end
