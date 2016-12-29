defmodule Bob do
  import String, only: [ends_with?: 2, trim: 1, upcase: 1, downcase: 1]

  def hey(input) do
    cond do
      question?(input) -> "Sure."
      shouting?(input) -> "Whoa, chill out!"
      silence?(input) -> "Fine. Be that way!"
      true -> "Whatever."
    end
  end

  defp question?(str), do: str |> ends_with?("?")
  defp shouting?(str), do: upcase(str) == str && downcase(str) != str
  defp silence?(str), do: str |> trim == ""

end
