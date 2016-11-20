defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t) :: boolean
  def isogram?(sentence) do
    not(
      sentence
      |> String.downcase
      |> String.replace(~r/\W/u, "")
      |> String.to_char_list
      |> first_char_repeated?
    )
  end

  defp first_char_repeated?([first_char | rest]) do
    Enum.member?(rest, first_char) or first_char_repeated?(rest)
  end
  defp first_char_repeated?(_) do false end

end
