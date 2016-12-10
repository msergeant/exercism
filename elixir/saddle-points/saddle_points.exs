defmodule Matrix do
  @doc """
  Parses a string representation of a matrix
  to a list of rows
  """
  @spec rows(String.t()) :: [[integer]]
  def rows(str) do
    str
    |> String.split("\n")
    |> Enum.map(&point_from_string/1)
  end

  @doc """
  Parses a string representation of a matrix
  to a list of columns
  """
  @spec columns(String.t()) :: [[integer]]
  def columns(str) do
    rows(str)
    |> List.zip
    |> Enum.map(&Tuple.to_list(&1))
  end

  @doc """
  Calculates all the saddle points from a string
  representation of a matrix
  """
  @spec saddle_points(String.t()) :: [{integer, integer}]
  def saddle_points(str) do
    _rows = rows(str)
    _columns = columns(str)

    row_columns(length(_rows), length(_columns))
    |> Enum.filter(fn(point) ->
      is_max_in_row?(point, _rows) and is_min_in_col?(point, _columns)
    end)
  end

  defp point_from_string(str) do
    str
    |> String.split
    |> Enum.map(&String.to_integer/1)
  end

  defp is_max_in_row?({col, row}, list) do
    full_row = Enum.fetch!(list, col)

    Enum.fetch!(full_row, row) == Enum.max(full_row)
  end

  defp is_min_in_col?({col, row}, list) do
    full_col = Enum.fetch!(list, row)

    Enum.fetch!(full_col, col) == Enum.min(full_col)
  end

  defp row_columns(row_length, col_length) do
    for row <- 0..col_length - 1, col <- 0..row_length - 1, do: {col, row}
  end
end
