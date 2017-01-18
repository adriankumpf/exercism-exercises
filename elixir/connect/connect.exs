defmodule Connect do
  @doc """
  Calculates the winner (if any) of a board
  using "O" as the white player
  and "X" as the black player
  """
  @spec result_for([String.t]) :: :none | :black | :white
  def result_for(board) do
    board
    |> add_coords
    |> determine_winner
  end

  defp add_coords(board) do
    for {row, y} <- (board |> Enum.with_index),
        {el, x}  <- (row |> String.graphemes |> Enum.with_index) do
      {x, y, el}
    end
    |> Enum.chunk(board |> Enum.at(0) |> String.length)
  end

  defp determine_winner(board) do
    cond do
      won?(board, "O") -> :white
      won?(board, "X") -> :black
      true             -> :none
    end
  end

  defp won?(board, player) do
    entry = find_entry(board, player)

    board
    |> get_last_path_element([entry])
    |> reached_other_side?(player, board)
  end

  defp find_entry(board, "X" = player) do
    board
    |> Enum.map(fn [y0 | _] -> y0 end)
    |> Enum.find(fn {_, _, p} -> p === player end)
  end
  defp find_entry(board, "O" = player) do
    board
    |> List.first
    |> Enum.find(fn {_, _, p} -> p === player end)
  end

  defp get_last_path_element(_, [nil]), do: nil
  defp get_last_path_element(_, [:none | path]), do: List.first(path)
  defp get_last_path_element(board, [{x, y, player} | _] = path) do
    neighbors = neighbors_coords(x, y)
    next = board
	   |> List.flatten
           |> Enum.find(:none, fn {x, y, p} ->
             p === player and {x, y} in neighbors and not {x, y, p} in path
           end)

    get_last_path_element(board, [next | path])
  end

  defp neighbors_coords(x, y) do
    for xn <- (x-1)..(x+1),
        yn <- (y-1)..(y+1),
        {xn, yn} != {x, y} do
      {xn, yn}
    end
  end

  defp reached_other_side?(nil, _, _), do: false
  defp reached_other_side?({_, y, _}, "O", board), do: length(board) - 1 === y
  defp reached_other_side?({x, _, _}, "X", board), do: (board |> List.first |> length) - 1 === x

end
