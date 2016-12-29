defmodule RunLengthEncoder do

  import List, only: [first: 1, duplicate: 2, to_integer: 1]

  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "HORSE" => "1H1O1R1S1E"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "1H1O1R1S1E" => "HORSE"
  """
  @spec encode(String.t) :: String.t
  def encode(string) do
    string
    |> String.to_charlist
    |> Enum.chunk_by(&(&1))
    |> Enum.map(&("#{Enum.count(&1)}#{[first(&1)]}"))
    |> Enum.join
  end

  @spec decode(String.t) :: String.t
  def decode(string) do
    string
    |> String.to_charlist
    |> Enum.chunk_by(&(&1 in ?0..?9))
    |> Enum.chunk(2)
    |> Enum.map(&duplicate_char/1)
    |> Enum.join
  end

  defp duplicate_char([count , char]) do
    char |> duplicate(to_integer(count))
  end

end
