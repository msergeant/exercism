defmodule Minesweeper do

  @doc """
  Annotate empty spots next to mines with the number of mines next to them.
  """
  @spec annotate([String.t]) :: [String.t]

  def annotate([]) do [] end
  def annotate(board) do
    len = length(board)
    width = board |> List.first |> String.length

    board_chars = board |> Enum.map(&String.graphemes/1)

    for(i <- 0..width-1, j <- 0..len-1, fn(_) -> true end, do: [i,j])
    |> Enum.reduce(board_chars, fn([i, j], acc) ->
      cond do
        char_at(board_chars, i, j) == "*" -> acc
        true -> replace_with_sum(acc, i, j)
      end
    end)
    |> Enum.map(&Enum.join/1)
  end

  def replace_with_sum(board_chars, i, j) do
    current_row = board_chars |> Enum.fetch! j
    replaced = current_row |> List.replace_at(i, to_string(sum_mines(board_chars, i, j)) |> String.replace("0", " "))

    board_chars
    |> List.replace_at(j, replaced)
  end

  def sum_mines(board_chars, i, j) do
    len = length(board_chars)
    width = board_chars |> List.first |> length

    for(x <- i-1..i+1,
        y <- j-1..j+1,
        ([x,y] != [i,j]) && (y < len) && (x < width),
        do: [x,y])
        |> Enum.filter(fn([x,y]) -> mine_at?(board_chars, x,y) end)
        |> length
  end

  defp mine_at?(_, i, j) when i < 0 or j < 0 do false end
  defp mine_at?(board_chars, i, j) do
    char_at(board_chars, i, j) == "*"
  end

  defp char_at(board_chars, i, j) do
    board_chars
    |> Enum.fetch!(j)
    |> Enum.fetch!(i)
  end
end
