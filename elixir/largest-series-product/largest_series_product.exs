defmodule Series do

  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t, non_neg_integer) :: non_neg_integer
  def largest_product(_, 0), do: 1
  def largest_product(str, size) do
    if size < 0 or String.length(str) < size, do: raise ArgumentError

    str
    |> String.to_integer
    |> Integer.digits
    |> Enum.chunk(size, 1)
    |> Enum.map(&product_of/1)
    |> Enum.max(fn -> 0 end)
  end

  defp product_of(chunk), do: Enum.reduce(chunk, 1, &(&1 * &2))

end
