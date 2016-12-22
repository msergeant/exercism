defmodule Wordy do

  @doc """
  Calculate the math problem in the sentence.
  """
  @spec answer(String.t) :: integer
  def answer(question) do
    question
    |> parse_instructions
    |> do_operations
  end

  defp parse_instructions(question) do
    question
    |> String.replace("multiplied by", "multipliedby")
    |> String.replace("divided by", "dividedby")
    |> String.split
    |> (fn(list) -> Enum.take(list, -(length(list) - 2)) end).()
  end

  defp do_operations([_ | tail]) when length(tail) < 2 do raise ArgumentError end
  defp do_operations([h | tail]) do
    tail
    |> Enum.chunk(2)
    |> Enum.reduce(strip_and_convert(h), fn([operator, num], acc) ->
      case operator do
        "plus" -> acc + strip_and_convert(num)
        "minus" -> acc - strip_and_convert(num)
        "multipliedby" -> acc * strip_and_convert(num)
        "dividedby" -> acc / strip_and_convert(num)
        _ -> raise ArgumentError
      end
    end)
  end

  defp strip_and_convert(num_string) do
    num_string
    |> String.replace(~r/\?/, "")
    |> String.to_integer
  end
end
