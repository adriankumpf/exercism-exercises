defmodule Allergies do

  @allergens ~w[eggs peanuts shellfish strawberries tomatoes chocolate pollen cats]

  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @spec list(non_neg_integer) :: [String.t]
  def list(flags) do
    flags
    |> Integer.digits(2)
    |> Enum.reverse
    |> Enum.with_index
    |> Enum.filter(fn {b,_} -> b == 1 end)
    |> Enum.map(fn {_, i} -> Enum.at(@allergens, i) end)
    |> Enum.filter(&(&1))
  end

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t) :: boolean
  def allergic_to?(flags, item), do: item in list(flags)

end
