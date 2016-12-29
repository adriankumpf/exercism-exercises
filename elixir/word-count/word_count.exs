defmodule Words do

  import Enum,   only: [ reduce: 3 ]
  import String, only: [ downcase: 1, split: 1 ]
  import Map,    only: [ update: 4 ]

  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) when is_binary(sentence) do
    sentence
    |> filter
    |> downcase
    |> split
    |> count_words
  end

  defp count_words(words) do
    words |> reduce(%{}, fn word, acc -> update(acc, word, 1, &(&1 + 1)) end)
  end

  defp filter(string) do
    for << g <- string >>, into: "", do: do_codepoint(g)
  end

  defp do_codepoint(g) when g in ?A..?Z,  do: <<g>>
  defp do_codepoint(g) when g in ?a..?z,  do: <<g>>
  defp do_codepoint(g) when g in ?0..?9,  do: <<g>>
  defp do_codepoint(g) when g == ?-,      do: <<g>>
  defp do_codepoint(g) when g >= 127,     do: <<g>>  # Extended ASCII & Unicode
  defp do_codepoint(_),                   do: <<32>> # Space
end
