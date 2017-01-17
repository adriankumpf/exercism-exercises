defmodule Minesweeper do

  @doc """
  Annotate empty spots next to mines with the number of mines next to them.
  """
  @spec annotate([String.t]) :: [String.t]

  def annotate([]), do: []
  def annotate(board) do
    width = board |> Enum.at(0) |> String.length
    board = add_coords(board)

    board
    |> Enum.map(&count_neighbor_mines(&1, board))
    |> Enum.chunk(width)
    |> Enum.map(&Enum.join/1)
  end

  defp add_coords(board) do
    for {row, y} <- (board |> Enum.with_index),
        {el, x}  <- (row |> String.graphemes |> Enum.with_index) do
      {x, y, el}
    end
  end

  defp count_neighbor_mines({_, _, "*"}, _), do: "*"
  defp count_neighbor_mines({x, y, " "}, board) do
    neighbors = for xn <- (x-1)..(x+1), yn <- (y-1)..(y+1), do: {xn, yn}

    mines = board
            |> Enum.filter(fn {x, y, el} -> el === "*" and {x, y} in neighbors end)
            |> length

    case mines do
      0 -> " "
      i -> Integer.to_string(i)
    end
  end

end
