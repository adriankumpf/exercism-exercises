defmodule Hexadecimal do
  @doc """
    Accept a string representing a hexadecimal value and returns the
    corresponding decimal value.
    It returns the integer 0 if the hexadecimal is invalid.
    Otherwise returns an integer representing the decimal value.

    ## Examples

      iex> Hexadecimal.to_decimal("invalid")
      0

      iex> Hexadecimal.to_decimal("af")
      175

  """

  @spec to_decimal(binary) :: integer
  def to_decimal(hex), do: hex |> String.downcase |> convert

  defp convert(str, dec \\ 0)
  defp convert("", dec), do: dec
  defp convert(<<h>> <> t, dec) when h in ?0..?9, do: convert(t, dec * 16 + h - ?0)
  defp convert(<<h>> <> t, dec) when h in ?a..?f, do: convert(t, dec * 16 + h - ?a + 10)
  defp convert(_, _), do: 0

end
