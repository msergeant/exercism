defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t], pos_integer) :: map
  def frequency(texts, workers) do
    pids = 1..workers
            |> Enum.map(fn(i) -> Task.start_link(fn -> loop(%{}) end) end)

    texts
    |> Enum.with_index
    |> Enum.each(fn({text, index}) ->
      { :ok, pid } = pids |> Enum.fetch!(rem(index,workers))
      send pid, {:add_text, text}
    end)

    pids
    |> Enum.reduce( %{}, fn({ :ok, pid }, acc) ->
         send pid, {:get_map, self()}
         receive do
           {map} -> combine_submaps(map, acc)
         end
       end)
  end

  defp loop(map) do
    receive do
      {:add_text, text} -> loop(combine_submaps(_frequency(text), map))
      {:get_map, caller} ->
        send caller, {map}
        loop(map)
    end
  end

  defp _frequency(text) do
    graphs = text |> String.downcase |> String.replace(~r/\W|[0-9]/u, "") |> String.graphemes

    graphs
    |> Enum.uniq
    |> Enum.reduce(%{}, fn(char, acc) ->
      existing = Map.get(acc, char, 0)
      count = Enum.filter(graphs, fn(c) -> c == char end) |> Enum.count

      Map.put(acc, char, existing + count)
    end)
  end

  defp combine_submaps(sub1, sub2) do
    Map.merge(sub1, sub2, fn(key, v1, v2) -> v1 + v2 end)
  end
end
