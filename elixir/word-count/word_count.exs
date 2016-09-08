defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    full_list = Enum.map(String.split(sentence, ~r/\s|_/), &String.downcase/1)
    word_list = Enum.uniq(Enum.map(full_list, &strip_invalid_chars/1))

    Enum.reduce(
      word_list,
      %{},
      fn(x, acc) ->
        cond do
          Regex.match?(~r/[a-z|0-9]+/, x) -> Map.put(acc, x, count_occurences(x, full_list))
          true -> acc
        end
      end
    )
  end

  defp strip_invalid_chars(word) do
    String.replace(word, ~r/[\.,!@$%^&]/, "")
  end

  defp count_occurences(word, sentence_list) do
    Enum.reduce(sentence_list, 0, fn(x, acc) ->
      cond do
        strip_invalid_chars(x) == word -> acc + 1
        true -> acc
      end
    end)
  end
end
