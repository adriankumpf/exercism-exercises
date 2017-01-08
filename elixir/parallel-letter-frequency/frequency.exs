defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t], pos_integer) :: map
  def frequency(texts, workers) do
    texts
    |> normalize
    |> split_up(workers)
    |> Enum.map(&Task.async(fn -> count(&1) end))
    |> Enum.map(&Task.await/1)
    |> merge
  end

  defp normalize(texts) do
    texts
    |> Enum.join
    |> String.trim
    |> String.downcase
    |> String.graphemes
    |> Enum.filter(&allowed_letter?/1)
  end

  defp allowed_letter?(<< l :: utf8 >>) when l in ?a..?z, do: true
  defp allowed_letter?(<< l :: utf8 >>) when l > ?~, do: true
  defp allowed_letter?(<< l :: utf8 >>) when l === ?\s, do: true
  defp allowed_letter?(_), do: false

  defp split_up([], _), do: []
  defp split_up(letters, n) do
    chunk_size = (length(letters) / n) |> Float.ceil |> round
    Enum.chunk(letters, chunk_size, chunk_size, [])
  end

  defp count(letters) do
    Enum.reduce(letters, %{}, fn l, acc ->
      Map.update(acc, l, 1, &(&1+1))
    end)
  end

  defp merge(maps) do
    Enum.reduce(maps, %{}, fn m, acc ->
      Map.merge(acc, m, fn _k, v1, v2 -> v1 + v2 end)
    end)
  end
end

