defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    full_list = sentence
                |> strip_invalid_chars
                |> String.split(~r/\s|_/)
                |> Enum.map(&String.downcase/1)

    Enum.reduce(
      Enum.uniq(full_list) ,
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
        x == word -> acc + 1
        true -> acc
      end
    end)
  end
end
