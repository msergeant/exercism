defmodule Diamond do
  @doc """
  Given a letter, it prints a diamond starting with 'A',
  with the supplied letter at the widest point.
  """
  @spec build_shape(char) :: String.t
  def build_shape(?A) do "A\n" end
  def build_shape(letter) do
    (
    ?A..letter
    |> Enum.map(&to_string([&1]))
    |> Enum.with_index
    |> Enum.map(&inbetween_spaces/1)
    |> pad_edges
    |> repeat_start_of_list
    |> Enum.join("\n")
    ) <> "\n"
  end

  defp inbetween_spaces({"A", 0}) do "A" end
  defp inbetween_spaces({char, index}) do
    spaces = (index - 1) * 2 + 1

    char <> String.duplicate(" ", spaces) <> char
  end

  defp pad_edges(string_list) do
    target_length = length(string_list) * 2
    string_list
    |> Enum.map(fn(string) ->
      missing_chars = target_length - String.length(string)
      String.duplicate(" ", div(missing_chars, 2)) <> string <> String.duplicate(" ", div(missing_chars, 2))
    end)
  end

  defp repeat_start_of_list(string_list) do
    [h | t] = Enum.reverse(string_list)
    Enum.reverse(t) ++ [h] ++ t
  end
end
