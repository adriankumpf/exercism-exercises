defmodule Roman do

  @n {
    [first: "I", last: "V"],
    [first: "X", last: "L"],
    [first: "C", last: "D"],
    [first: "M", last: nil]
  }

  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t
  def numerals(number) when number > 3000, do: raise "Not supported"
  def numerals(number), do: number |> Integer.digits |> _numerals

  defp _numerals([d3,d2,d1,d0]), do: "#{digit(3, d3)}" <> _numerals([d2,d1,d0])
  defp _numerals([d2,d1,d0]), do: "#{digit(2, d2)}" <> _numerals([d1,d0])
  defp _numerals([d1,d0]), do: "#{digit(1, d1)}" <> _numerals([d0])
  defp _numerals([d0]), do: "#{digit(0, d0)}"

  defp digit(_, 0), do: ""
  defp digit(i, 4), do: elem(@n, i)[:first] <> elem(@n, i)[:last]
  defp digit(i, 5), do: elem(@n, i)[:last]
  defp digit(i, 9), do: elem(@n, i)[:first] <> elem(@n, i+1)[:first]
  defp digit(i, d) when d < 4, do: elem(@n, i)[:first] |> String.duplicate(d)
  defp digit(i, d), do: elem(@n, i)[:last] <> (elem(@n, i)[:first] |> String.duplicate(d-5))

end
