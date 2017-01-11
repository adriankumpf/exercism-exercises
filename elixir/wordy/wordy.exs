defmodule Wordy do

  @doc """
  Calculate the math problem in the sentence.
  """
  @spec answer(String.t) :: integer
  def answer(question) do
    question
    |> String.replace_prefix("What is ", "")
    |> String.replace_suffix("?", "")
    |> String.split(" ")
    |> parse
  end

  defp parse([result]), do: result
  defp parse([a, "plus", b | rest]) do
    parse([to_int(a) + to_int(b) | rest])
  end
  defp parse([a, "minus", b | rest]) do
    parse([to_int(a) - to_int(b) | rest])
  end
  defp parse([a, "multiplied", "by", b | rest]) do
    parse([to_int(a) * to_int(b) | rest])
  end
  defp parse([a, "divided", "by", b | rest]) do
    parse([div(to_int(a), to_int(b)) | rest])
  end
  defp parse([a, "raised", "to", "the", bth, "power" | rest]) do
    b = bth |> String.replace("th", "") |> to_int
    parse([:math.pow(to_int(a), b) |> round | rest])
  end
  defp parse(_), do: raise ArgumentError

  defp to_int(str) when is_integer(str), do: str
  defp to_int(str), do: String.to_integer(str)


end
