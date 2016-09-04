defmodule Bob do
  def hey(input) do
    cond do
        all_whitespace?(input) -> "Fine. Be that way!"
        question?(input) -> "Sure."
        shouting?(input) -> "Whoa, chill out!"
        true-> "Whatever."

    end
  end

  defp all_whitespace?(input) do
    Regex.match?(~r/\A\s*\z/, input)
  end

  defp question?(input) do
    Regex.match?(~r/\?\z/, input)
  end

  defp shouting?(input) do
    contains_capital_letters?(input) and not(contains_lowercase_letters?(input))
  end

  defp contains_capital_letters?(input) do
    Regex.match?(~r/([A-Z]|[\x{0410}-\x{042F}])+/u, input)
  end

  defp contains_lowercase_letters?(input) do
    Regex.match?(~r/([a-z])+/u, input)
  end
end
