defmodule Change do
  @doc """
  Determine the least number of coins to be given to the user such
  that the sum of the coins' value would equal the correct amount of change.
  It returns :error if it is not possible to compute the right amount of coins.
  Otherwise returns the tuple {:ok, map_of_coins}

  ## Examples

  iex> Change.generate(3, [5, 10, 15])
  :error

  iex> Change.generate(18, [1, 5, 10])
  {:ok, %{1 => 3, 5 => 1, 10 => 1}}

  """

  @spec generate(integer, list) :: {:ok, map} | :error
  def generate(amount, coins), do: _generate(amount, coins, %{})

  def _generate(0, [], map), do:  {:ok, map}
  def _generate(_, [], _), do: :error
  def _generate(amount, coins, map) do
    [largest_coin | remaining_coins] = Enum.sort(coins, &>/2)

    with true <- largest_coin <= amount,
         amount_left = rem(amount, largest_coin),
         number_of_coins = div(amount, largest_coin),
         new_map = Map.put(map, largest_coin, number_of_coins),
         result = {:ok, _} <- _generate(amount_left, remaining_coins, new_map) do
      result
    else
      _ -> _generate(amount, remaining_coins, Map.put(map, largest_coin, 0))
    end
  end

end
