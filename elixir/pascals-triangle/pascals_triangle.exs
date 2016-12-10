defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]

  def rows(num) do
    1..num
    |> Enum.reduce([], fn(n, acc) ->
      acc ++ [single_row(n)]
    end)
  end

  defp single_row(1) do [1] end
  defp single_row(num) do
    previous_row = single_row(num - 1)

    ( 0..num - 2
      |> Enum.reduce([], fn(index, acc) ->
        acc ++ [sum_consecutive_nums(previous_row, index)]
      end)
    ) ++ [1]
  end

  defp sum_consecutive_nums(previous_row, index) when index > 0 do
    Enum.fetch!(previous_row, index - 1) + Enum.fetch!(previous_row, index)
  end
  defp sum_consecutive_nums(_, _) do 1 end
end
