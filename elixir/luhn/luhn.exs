defmodule Luhn do
  @doc """
  Calculates the total checksum of a number
  """
  @spec checksum(String.t()) :: integer
  def checksum(number) when is_bitstring(number) do
    number
    |> String.to_integer
    |> Integer.digits
    |> Enum.reverse
    |> Enum.with_index
    |> Enum.map(&luhn/1)
    |> Enum.sum
  end

  defp luhn({digit, i}) when rem(i, 2) === 0, do: digit
  defp luhn({digit, _}) when digit * 2 > 9, do: (digit * 2) - 9
  defp luhn({digit, _}), do: digit * 2

  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(number), do: number |> checksum |> rem(10) === 0

  @doc """
  Creates a valid number by adding the correct
  checksum digit to the end of the number
  """
  @spec create(String.t()) :: String.t()
  def create(number) when is_bitstring(number) do
    last_digit = number<>"0"
                 |> checksum
                 |> rem(10)
                 |> tens_complement

    number <> "#{last_digit}"
  end

  defp tens_complement(n), do: rem(10 - n, 10)

end
