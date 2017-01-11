defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(n), do: factors(n, 2)

  defp factors(1, _), do: []
  defp factors(n, f) when f * f > n, do: [n]
  defp factors(n, f) when rem(n, f) == 0, do: [f] ++ factors(div(n, f), f)
  defp factors(n, f), do: factors(n, f + 1)

end
