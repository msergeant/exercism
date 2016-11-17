defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: { :ok, kind } | { :error, String.t }
  def kind(a, a, a) when a > 0 do { :ok, :equilateral } end
  def kind(a, b, c) when a > 0 and b > 0 and c > 0 do
    cond do
      degnerate?(a,b,c) -> { :error, "side lengths violate triangle inequality"  }
      degnerate?(a,c,b) -> { :error, "side lengths violate triangle inequality"  }
      degnerate?(c,b,a) -> { :error, "side lengths violate triangle inequality"  }
      a == b -> { :ok, :isosceles }
      a == c -> { :ok, :isosceles }
      b == c -> { :ok, :isosceles }
      true -> { :ok, :scalene }
    end
  end
  def kind(_, _, _) do { :error, "all side lengths must be positive"  } end

  defp degnerate?(a, b, c) when a + b > c do false end
  defp degnerate?(a, b, c) when a + b < c do true end
  defp degnerate?(a, b, c) when a == b do true end

end
