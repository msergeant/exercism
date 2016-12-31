defmodule CryptoSquare do
  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t) :: String.t
  def encode("") do "" end
  def encode(str) do
    norm_string = normalize(str)
    len = :math.pow(String.length(norm_string), 0.5) |> round

    norm_string
    |> normalize
    |> String.graphemes
    |> squarify(len)
  end

  defp normalize(str) do
    str
    |> String.downcase
    |> String.replace(~r/\W/u, "")
  end

  defp squarify(list, len) do
    init = 1..(row_count(list, len)) |> Enum.map(fn(_) -> "" end)

    list
    |> Enum.with_index
    |> Enum.reduce(init, fn({letter, index}, acc) ->
      spot = rem(index, length(acc))
      orig = Enum.fetch!(acc, spot)

      List.replace_at(acc, spot, orig <> letter)
    end)
    |> Enum.join(" ")
  end

  defp row_count(list, len) when len * len == length(list) do len end
  defp row_count(list, len)  do len + 1 end
end
