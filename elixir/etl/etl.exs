defmodule ETL do
  @doc """
  Transform an index into an inverted index.

  ## Examples

  iex> ETL.transform(%{"a" => ["ABILITY", "AARDVARK"], "b" => ["BALLAST", "BEAUTY"]})
  %{"ability" => "a", "aardvark" => "a", "ballast" => "b", "beauty" =>"b"}
  """
  @spec transform(map) :: map
  def transform(input) do
    Enum.reduce(input, %{}, fn({key, values}, acc) ->
      add_all_values(key, values, acc)
    end)
  end

  defp add_all_values(key, values, output) do
    Enum.reduce(values, output, fn(word, acc) ->
      Map.put(acc, word |> String.downcase, key)
    end)
  end
end
