defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    Enum.reduce(
      String.split(string, ~r/(?=[A-Z])|\s|-/),
      "",
      fn(x, acc) -> acc <> shorten(x) end
    )
  end

  defp shorten(string) do
    String.first(string)
    |> String.capitalize
  end
end
