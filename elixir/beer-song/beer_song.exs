defmodule BeerSong do

  import String, only: [capitalize: 1]

  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t
  def verse(number) do
    """
    #{first_sentence(number - 1)}
    #{second_sentence(number - 2)}
    """
  end

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t) :: String.t
  def lyrics(range \\ 100..1), do: Enum.map_join(range, "\n", &verse/1)

  defp first_sentence(n), do: "#{bottles(n)} on the wall, #{bottles(n)}." |> capitalize

  defp second_sentence(-1), do: "Go to the store and buy some more, #{bottles(99)} on the wall."
  defp second_sentence(0), do: "Take it down and pass it around, #{bottles(0)} on the wall."
  defp second_sentence(n), do: "Take one down and pass it around, #{bottles(n)} on the wall."

  defp bottles(0), do: "no more bottles of beer"
  defp bottles(1), do: "1 bottle of beer"
  defp bottles(n), do: "#{n} bottles of beer"

end
