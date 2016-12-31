defmodule Allergies do
  use Bitwise
  @allergy_list ~w[eggs peanuts shellfish strawberries tomatoes chocolate pollen cats]

  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @spec list(non_neg_integer) :: [String.t]
  def list(flags) do
    @allergy_list
    |> Enum.with_index
    |> Enum.filter(fn({_, index}) ->
      ((:math.pow(2, index) |> round) &&& flags) > 0
    end)
    |> Enum.map(fn({allergy, _}) -> allergy end)
  end

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t) :: boolean
  def allergic_to?(flags, item) do
    Enum.member?(list(flags), item)
  end
end
