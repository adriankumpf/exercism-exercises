defmodule Pangram do

  import Enum, only: [to_list: 1]
  import String, only: [downcase: 1]

  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """

  @spec pangram?(String.t) :: boolean
  def pangram?(sentence) do
     to_list(?a..?z) -- (sentence |> downcase |> to_charlist) == []
  end

end
