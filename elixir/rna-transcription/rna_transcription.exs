defmodule RNATranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RNATranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna), do: dna |> Enum.map(&translate/1)

  defp translate(?A), do: ?U
  defp translate(?T), do: ?A
  defp translate(?C), do: ?G
  defp translate(?G), do: ?C

end
