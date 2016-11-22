defmodule Garden do
  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """

  @children ~w(alice bob charlie david eve fred ginny harriet ileana joseph kincaid larry)a
  @plants %{?G => :grass, ?C => :clover, ?R => :radishes, ?V => :violets}

  @spec info(String.t(), list) :: map
  def info(info_string) do
    info(info_string, @children)
  end
  def info(info_string, student_names) do
    #%{ alice: plant_tuple(0, info_string) }
    0..(length(student_names) - 1)
    |> Enum.reduce(%{}, fn(index, acc) ->
      Map.put(acc, Enum.fetch!(student_names |> Enum.sort, index), plant_tuple(index, info_string))
    end)
  end

  defp plant_tuple(n, string) do
    row_strings = String.split(string, "\n")
    Enum.reduce(row_strings, {}, fn(row_string, acc) ->
      char_list = Regex.scan(~r/\S\S/, row_string) |> List.flatten |> Enum.map(&String.to_char_list/1)
      two_letters = Enum.fetch(char_list, n)

      tuple_from_two_letters(acc, two_letters)
    end)
  end

  defp tuple_from_two_letters(tuple, {:ok, two_letters} ) do
    tuple
    |> Tuple.append(Map.get(@plants, Enum.fetch!(two_letters, 0)))
    |> Tuple.append(Map.get(@plants, Enum.fetch!(two_letters, 1)))
  end
  defp tuple_from_two_letters(tuple, _ ) do tuple end
end
