defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
      :monday | :tuesday | :wednesday
    | :thursday | :friday | :saturday | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date
  def meetup(year, month, weekday, schedule) do
    day_int = day_of_week(weekday)
    seven_day_range(schedule, month)
    |> Enum.map(fn(day) -> {year, month, day} end)
    |> Enum.find(fn(date) -> :calendar.day_of_the_week(date) == day_int end)
  end

  defp seven_day_range(:first, _) do 1..7 end
  defp seven_day_range(:second, _) do 8..14 end
  defp seven_day_range(:third, _) do 15..21 end
  defp seven_day_range(:fourth, _) do 22..28 end
  defp seven_day_range(:teenth, _) do 13..19 end
  defp seven_day_range(:last, month) do
    cond do
      Enum.member?([1,3,5,7,8,10,12], month) -> 31..25
      Enum.member?([4,6,9,11], month) -> 30..24
      true -> 28..22
    end
  end

  defp day_of_week(:monday) do 1 end
  defp day_of_week(:tuesday) do 2 end
  defp day_of_week(:wednesday) do 3 end
  defp day_of_week(:thursday) do 4 end
  defp day_of_week(:friday) do 5 end
  defp day_of_week(:saturday) do 6 end
  defp day_of_week(:sunday) do 7 end

end
