defmodule CryptoSquare do

  @whitelist Enum.to_list(?a..?z) ++ Enum.to_list(?0..?9)

  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t) :: String.t
  def encode(""), do: ""
  def encode(string) do
    normalized = normalize(string)
    row_number  = number_of_rows(normalized)

    normalized
    |> Enum.chunk(row_number, row_number, List.duplicate("", row_number))
    |> List.zip
    |> Enum.map_join(" ", &Tuple.to_list/1)
  end

  defp normalize(string) do
    string
    |> String.downcase
    |> String.graphemes
    |> Enum.filter(&whitelist/1)
  end

  defp whitelist(<< g >>) when g in @whitelist, do: true
  defp whitelist(_), do: false

  defp number_of_rows(graphemes) do
    graphemes
    |> length
    |> :math.sqrt
    |> Float.ceil
    |> round
  end

end
