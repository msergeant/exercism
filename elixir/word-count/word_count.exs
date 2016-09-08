defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    full_list = String.split(sentence)
    word_list = Enum.uniq(full_list)

    Enum.reduce(
      word_list,
      %{},
      fn(x, acc) ->
        Map.put(acc, x, count_occurences(x, full_list))
      end
    )
  end

  defp count_occurences(word, sentence_list) do
    Enum.reduce(sentence_list, 0, fn(x, acc) ->
      cond do
        x == word -> acc + 1
        true -> acc
      end
    end)
  end
end
