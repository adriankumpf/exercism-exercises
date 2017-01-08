defmodule Binary do
  use Bitwise
  @doc """
  Convert a string containing a binary number to an integer.

  On errors returns 0.
  """
  @spec to_decimal(String.t) :: non_neg_integer
  def to_decimal(str) when is_bitstring(str), do: str |> to_charlist |> to_decimal
  def to_decimal(chars), do: to_decimal(chars, valid?(chars))
  defp to_decimal(_, false), do: 0
  defp to_decimal(bin, true), do: Enum.reduce(bin, 0, &shift/2)

  defp shift(?0, acc), do: acc <<< 1
  defp shift(?1, acc), do: acc <<< 1 ||| 1

  defp valid?(chars), do: Enum.all?(chars, &(&1 in ?0..?1))

end
