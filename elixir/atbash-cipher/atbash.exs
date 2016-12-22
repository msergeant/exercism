defmodule Atbash do
  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t) :: String.t
  def encode(plaintext) do
    plaintext
    |> String.downcase
    |> String.replace(~r/\W/, "")
    |> String.to_char_list
    |> Enum.map(&encode_single_char/1)
    |> Enum.chunk(5, 5, [])
    |> Enum.map(&to_string/1)
    |> Enum.join(" ")
  end

  defp encode_single_char(char) when char <= ?z and char >= ?a do
    (?z - (char - ?a))
  end
  defp encode_single_char(char), do: char
end
