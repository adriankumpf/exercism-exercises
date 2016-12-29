defmodule Raindrops do

  import Enum, only: [filter_map: 3, join: 1]

  @rain_sounds [Pling: 3, Plang: 5, Plong: 7]

  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
  just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t
  def convert(number) do
    @rain_sounds
    |> filter_map(&prime_factor?(&1, number), &elem(&1, 0))
    |> matched?(number)
  end

  defp prime_factor?({_sound, pf}, number), do: rem(number, pf) == 0

  defp matched?([], number), do: "#{number}"
  defp matched?(drop, _number), do: join(drop)
end
