defmodule Triangle do

  @e_neg { :error, "all side lengths must be positive" }
  @e_ineq { :error, "side lengths violate triangle inequality" }

  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: { :ok, kind } | { :error, String.t }

  def kind(a, b, c) when a<=0 or b<=0 or c<= 0, do: @e_neg
  def kind(a, b, c) when a>=b+c or b>=a+c or c>=a+b, do: @e_ineq
  def kind(a, b, c), do: get_kind(a, b, c)

  defp get_kind(a, a, a), do: { :ok, :equilateral }
  defp get_kind(a, _, a), do: { :ok, :isosceles }
  defp get_kind(a, a, _), do: { :ok, :isosceles }
  defp get_kind(_, a, a), do: { :ok, :isosceles }
  defp get_kind(_, _, _), do: { :ok, :scalene }

end
