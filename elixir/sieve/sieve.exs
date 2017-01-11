defmodule Sieve do

  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit) do
    2..limit
    |> Enum.to_list
    |> sieve(2)
  end

  defp sieve(numbers, nil), do: numbers
  defp sieve(numbers, p) do
    new_numbers = Enum.filter(numbers, &(&1 === p or rem(&1, p) !== 0))
    prime = Enum.find(new_numbers, &(&1>p))
    sieve(new_numbers, prime)
  end

end
