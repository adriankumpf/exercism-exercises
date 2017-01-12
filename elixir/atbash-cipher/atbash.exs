defmodule Atbash do

  @alphabet ?a..?z |> Enum.to_list

  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t) :: String.t
  def encode(plaintext) do
    plaintext
    |> String.downcase
    |> to_charlist
    |> whitelist
    |> shift
    |> Enum.chunk(5, 5, [])
    |> Enum.join(" ")
  end

  defp whitelist([]), do: []
  defp whitelist([h | tail]) when h in ?a..?z or h in ?0..?9 do
    [h | whitelist(tail)]
  end
  defp whitelist([_ | tail]) do
    whitelist(tail)
  end

  defp shift([]), do: []
  defp shift([h | tail]) when h in ?0..?9 do
    [h | shift(tail)]
  end
  defp shift([h | tail]) do
    index = Enum.find_index(@alphabet, &(&1 == h))
    encoded = Enum.at(@alphabet, -(index + 1))
    [encoded | shift(tail)]
  end

end
