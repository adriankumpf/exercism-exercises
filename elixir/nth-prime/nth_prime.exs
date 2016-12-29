defmodule Prime do

  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(0), do: raise "Whaaat?"
  def nth(count) do
    Stream.unfold(1, &({&1,&1+1}))
    |> Stream.filter(&prime?/1)
    |> Enum.at(count)
  end

  def prime?(n), do: factors(n, div(n, 2)) == [1]

  def factors(1, _), do: [1]
  def factors(_, 1), do: [1]
  def factors(n, i) when rem(n, i) == 0, do: [i] ++ factors(n, i-1)
  def factors(n, i), do: factors(n, i-1)

end
