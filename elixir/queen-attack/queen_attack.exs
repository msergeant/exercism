defmodule Queens do
  @type t :: %Queens{ black: {integer, integer}, white: {integer, integer} }
  defstruct black: nil, white: nil

  @doc """
  Creates a new set of Queens
  """
  @spec new() :: Queens.t()
  @spec new({integer, integer}, {integer, integer}) :: Queens.t()
  def new do
    new({0,3}, {7,3})
  end
  def new(a, a) do raise ArgumentError end
  def new(white, black) do
    %Queens{ white: white, black: black }
  end

  @doc """
  Gives a string reprentation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(queens) do
    row_columns
    |> Enum.reduce("", fn({row, col}, full_string) ->
        out_string = full_string <> spot_char({row, col}, queens)
        case col do
          7 -> String.trim(out_string) <> "\n"
          _ -> out_string
        end
    end)
    |> String.trim
  end

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(%Queens{ black: {row, _}, white: {row, _} }) do true end
  def can_attack?(%Queens{ black: {_, col}, white: {_, col} }) do true end
  def can_attack?(%Queens{ black: {row1, col1}, white: {row2, col2} }) when abs(row1 - row2) == abs(col1 - col2) do true end
  def can_attack?(_) do false end

  defp spot_char(spot, %Queens{ black: spot, white: _ }) do "B " end
  defp spot_char(spot, %Queens{ black: _, white: spot }) do "W " end
  defp spot_char(_, _) do "_ " end

  defp row_columns do
    Enum.map(0..7, fn(row) ->
      Enum.map(0..7, fn(col) ->
        {row, col}
      end)
    end) |> List.flatten
  end
end
