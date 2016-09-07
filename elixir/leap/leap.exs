defmodule Year do
  @doc """
  Returns whether 'year' is a leap year.

  A leap year occurs:

  on every year that is evenly divisible by 4
    except every year that is evenly divisible by 100
      unless the year is also evenly divisible by 400
  """
  @spec leap_year?(non_neg_integer) :: boolean
  def leap_year?(year) do
    cond do
      divisible_by?(400, year) -> true
      divisible_by?(100, year) -> false
      divisible_by?(4, year) -> true
      true -> false
    end
  end

  defp divisible_by?(num, year) do
    rem(year, num) == 0
  end
end
