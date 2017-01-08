defmodule Binary do
  use Bitwise
  @doc """
  Convert a string containing a binary number to an integer.

  On errors returns 0.
  """
  @spec to_decimal(String.t) :: non_neg_integer
  def to_decimal(str), do: to_decimal(str, 0)
  defp to_decimal("0" <> tail, dec), do: to_decimal(tail, dec * 2)
  defp to_decimal("1" <> tail, dec), do: to_decimal(tail, dec * 2 + 1)
  defp to_decimal("", dec), do: dec
  defp to_decimal(_, _), do: 0

end
