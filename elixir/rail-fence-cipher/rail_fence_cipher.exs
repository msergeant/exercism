defmodule RailFenceCipher do
  @doc """
  Encode a given plaintext to the corresponding rail fence ciphertext
  """
  @spec encode(String.t, pos_integer) :: String.t
  def encode(str, 1) do str end
  def encode(str, rails) do
    zigzag_rows(str, rails)
    |> Enum.join
  end

  @doc """
  Decode a given rail fence ciphertext to the corresponding plaintext
  """
  @spec decode(String.t, pos_integer) :: String.t
  def decode(str, 1) do str end
  def decode(str, rails) do
    letter_counts =
      zigzag_rows(str, rails)
      |> Enum.reduce({str, []}, fn(rail_str, {acc_str, list}) ->
        len = String.length(rail_str)
        { String.slice(acc_str, len..-1), list ++ [String.slice(acc_str, 0..len)]}
      end)
      |> elem(1)
      |> Enum.map(fn(rail_str) -> {0, rail_str} end)

    0..String.length(str)-1
    |> Enum.reduce({letter_counts, ""}, fn(index, {counts, acc}) ->
      r_i = rail_index(index, rails)
      {count, string_to_look_at} = Enum.fetch!(counts, r_i)
      char = String.slice(string_to_look_at, count..count)

      {List.replace_at(counts, r_i, {count+1, string_to_look_at}), acc <> char}
    end)
    |> elem(1)
  end

  defp add_at_index(list, index, char) when length(list) <= index do
    List.insert_at(list, index, char)
  end
  defp add_at_index(list, index, char) do
    existing = Enum.fetch!(list, index)
    List.replace_at(list, index, existing <> char)
  end

  defp zigzag_rows(str, rails) do
    str
    |> String.graphemes
    |> Enum.with_index
    |> Enum.reduce([""], fn({char, index}, list)->
      add_at_index(list, rail_index(index, rails), char)
    end)
  end

  defp rail_index(index, rails) do
    position_count = rails + rails - 2
    pos = rem(index, position_count)
    if(pos <= div(position_count, 2), do: pos, else: position_count - pos)
  end
end
