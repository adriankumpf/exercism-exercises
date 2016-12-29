defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    limit |> get_multiples(factors) |> Enum.sum
  end

  defp get_multiples(limit, factors) do
    1..(limit-1)
    |> Enum.to_list
    |> Enum.filter(fn n ->
      Enum.any?(factors, fn f -> rem(n,f) == 0 end)
    end)
  end
end
