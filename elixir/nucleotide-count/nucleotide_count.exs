defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a NucleotideCount strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) when nucleotide in @nucleotides do
    strand |> Enum.count(fn n -> n === nucleotide end)
  end


  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand) do
    Enum.reduce(strand, init_nucleotide_map(), &update_count/2)
  end

  defp init_nucleotide_map() do
    @nucleotides |> Enum.into(%{}, fn x -> {x, 0} end)
  end

  defp update_count(nucleotide, acc) do
    Map.update(acc, nucleotide, 1, &(&1 + 1))
  end
end
