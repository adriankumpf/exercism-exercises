defmodule Anagram do

  import String, only: [downcase: 1]
  import Enum, only: [filter: 2, sort: 1]
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
    candidates |> filter(fn  c ->
      normalize(c) == normalize(base) && downcase(c) != downcase(base)
    end)
  end

  defp normalize(str) do
    str |> downcase |> to_charlist |> sort
  end

end
