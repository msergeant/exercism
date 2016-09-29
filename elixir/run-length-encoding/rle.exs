defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "HORSE" => "1H1O1R1S1E"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "1H1O1R1S1E" => "HORSE"
  """
  @spec encode(String.t) :: String.t
  def encode(string) do
    String.to_char_list(string)
    |> Enum.reduce("", &char_counter/2)
  end

  @spec decode(String.t) :: String.t
  def decode(string) do
    recursive_decode(string, "")
  end

  defp recursive_decode("", out_string) do
    out_string
  end

  defp recursive_decode(string, out_string) do
    {last_char, counter, string_without_last} = pop_end_char_count(string)
    recursive_decode(string_without_last, Enum.reduce(1..counter, "", fn(_, acc) -> acc <> last_char end) <> out_string)
  end

  defp char_counter(char, "") do
    "1" <> to_string([char])
  end

  defp char_counter(char, string) do
    {_, counter, string_without_last} = pop_end_char_count(string)

    cond do
      List.last(String.to_char_list(string)) == char -> string_without_last <> to_string(counter + 1) <> to_string([char])
      true -> string <> char_counter(char, "")
    end
  end

  defp pop_end_char_count(string) do
    last_char = String.slice(string, -1, 1)
    counter = String.split(string, ~r/[A-Z]/) |> Enum.take(-2) |> List.first |> String.to_integer
    string_without_last = String.slice(string, 0, String.length(string) - String.length(to_string(counter)) - 1)

    {last_char, counter, string_without_last}
  end

end
