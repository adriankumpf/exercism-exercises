defmodule BracketPush do

  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t) :: boolean
  def check_brackets(str) do
    str |> String.graphemes |> balanced?
  end

  defp balanced?(list), do: balanced?(list, [])

  defp balanced?([], []), do: true
  defp balanced?([], _), do: false

  defp balanced?([b|tail], stack) when b in ~w'{ ( [', do: balanced?(tail, [b|stack])
  defp balanced?(["}"|tail], ["{"|stack]), do: balanced?(tail, stack)
  defp balanced?([")"|tail], ["("|stack]), do: balanced?(tail, stack)
  defp balanced?(["]"|tail], ["["|stack]), do: balanced?(tail, stack)
  defp balanced?([b|_], _) when b in ~w'} ) ]', do: false
  defp balanced?([_|tail],stack), do: balanced?(tail,stack)

end
