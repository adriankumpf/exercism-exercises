defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(num), do: do_rows(num-1)

  defp do_rows(n, rows \\ [[1]])
  defp do_rows(0, rows), do: rows
  defp do_rows(n, rows) do
    last_row = List.last(rows)
    new_row = Enum.zip([0] ++ last_row, last_row ++ [0])
              |> Enum.map(fn {a, b} -> a + b end)

    do_rows(n-1, rows ++ [new_row])
  end

end
