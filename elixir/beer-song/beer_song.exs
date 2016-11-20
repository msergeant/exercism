defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t
  def verse(number) do
    first_sentence(number) <> "\n" <> second_sentence(number) <> "\n"
  end

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t) :: String.t
  def lyrics do
    lyrics(100..1)
  end
  def lyrics(range) do
    Enum.map(range, &verse/1) |> Enum.join("\n")
  end

  defp bottle_text(1) do " bottle " end
  defp bottle_text(_) do " bottles " end

  defp number_text(0) do "No more" end
  defp number_text(n) do to_string(n) end

  defp first_sentence(number) do
    [
      number_text(number - 1),
      bottle_text(number - 1),
      "of beer on the wall, ",
      number_text(number - 1) |> String.downcase,
      bottle_text(number - 1),
      "of beer."
    ] |> Enum.join
  end

  defp second_sentence(1) do
    "Go to the store and buy some more, 99 bottles of beer on the wall."
  end
  defp second_sentence(2) do
    "Take it down and pass it around, no more bottles of beer on the wall."
  end
  defp second_sentence(number) do
    [
    "Take one down and pass it around, ",
    number_text(number - 2),
    bottle_text(number - 2),
    "of beer on the wall."
    ] |> Enum.join
  end
end
