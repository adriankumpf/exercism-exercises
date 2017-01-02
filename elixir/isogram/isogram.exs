defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t) :: boolean
  def isogram?(sentence) do
    sentence
    |> remove_special_chars
    |> count_letters
    |> Enum.all?(&match?({_, 1}, &1))
  end

  defp count_letters(sentence) do
    sentence |> Enum.reduce(%{}, fn letter, acc ->
      Map.update(acc, letter, 1, &(&1 + 1))
    end)
  end

  defp remove_special_chars(sentence) do
    sentence
    |> String.downcase
    |> String.graphemes
    |> Enum.filter(&normalChar?/1)
  end

  defp normalChar?(<< g :: utf8 >>) when g in ?a..?z, do: true
  defp normalChar?(<< g :: utf8 >>) when g >= 127, do: true  # Extended ASCII & Unicode
  defp normalChar?(_), do: false

end
