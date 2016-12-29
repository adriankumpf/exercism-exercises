defmodule Scrabble do

  @points [
    { 1,  ~w( A E I O U L N R S T ) },
    { 2,  ~w( D G ) },
    { 3,  ~w( B C M P ) },
    { 4,  ~w( F H V W Y ) },
    { 5,  ~w( K ) },
    { 8,  ~w( J X ) },
    { 10, ~w( Q Z ) },
  ]

  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t) :: non_neg_integer

  def score(word) when is_bitstring(word) do
    word
    |> String.trim
    |> String.split("")
    |> Enum.reduce(0, fn letter, acc ->
      letter |> get_points |> Kernel.+(acc)
    end)
  end

  defp get_points(letter) do
    @points
    |> Enum.find({0, []}, fn {_,letters} ->
      Enum.member?(letters, String.upcase(letter))
    end)
    |> elem(0)
  end

end
