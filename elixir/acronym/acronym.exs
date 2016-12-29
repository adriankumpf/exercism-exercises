defmodule Acronym do

  import String, only: [upcase: 1, split: 2, first: 1]
  import Enum, only: [join: 2, map: 2]

  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> insert_spaces
    |> split(" ")
    |> map(&first/1)
    |> join("")
    |> upcase
  end

  defp insert_spaces(string) do
    for << g <- string >>, into: "", do: do_insert_spaces(g)
  end

  defp do_insert_spaces(g) when g in ?A..?Z, do: << ?\s, g >>
  defp do_insert_spaces(g), do: << g >>

end

