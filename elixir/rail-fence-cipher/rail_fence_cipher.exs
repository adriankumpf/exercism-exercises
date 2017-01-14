defmodule RailFenceCipher do
  @doc """
  Encode a given plaintext to the corresponding rail fence ciphertext
  """
  @spec encode(String.t, pos_integer) :: String.t
  def encode(str, 1), do: str
  def encode(str, rails), do: str |> String.graphemes |> do_encode(rails)

  defp do_encode(msg, rails) do
    pattern(rails, length(msg))
    |> Enum.map_join(fn {_, i} -> Enum.at(msg, i) end)
  end

  @doc """
  Decode a given rail fence ciphertext to the corresponding plaintext
  """
  @spec decode(String.t, pos_integer) :: String.t
  def decode(str, 1), do: str
  def decode(str, rails), do: str |> String.graphemes |> do_decode(rails)

  defp do_decode(msg, rails) do
    pattern = pattern(rails, length(msg))

    msg
    |> Enum.zip(pattern)
    |> Enum.sort_by(fn {_, {_, i}} -> i end)
    |> Enum.map_join(fn {char, _} -> char end)
  end

  defp pattern(rails, size) do
    Stream.concat(0..(rails - 1), (rails - 2)..1)
    |> Stream.cycle
    |> Enum.zip(0..(size - 1))
    |> Enum.sort
  end

end
