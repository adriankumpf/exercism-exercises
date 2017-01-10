defmodule Queens do
  @type t :: %Queens{ black: {integer, integer}, white: {integer, integer} }
  defstruct black: nil, white: nil

  @doc """
  Creates a new set of Queens
  """
  @spec new() :: Queens.t()
  @spec new({integer, integer}, {integer, integer}) :: Queens.t()
  def new(white \\ {0, 3}, black \\ {7, 3})
  def new(pos, pos), do: raise ArgumentError
  def new(white, black), do: %Queens{black: black, white: white}

  @doc """
  Gives a string reprentation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(queens) do
    board = for r <- 0..7, c <- 0..7, do: {r, c}

    board
    |> Enum.map(&insert_queens(&1, queens))
    |> Enum.chunk(8)
    |> Enum.map_join("\n", &Enum.join(&1, " "))
  end

  defp insert_queens(field, %{black: black, white: white}) do
    case field do
      ^black -> "B"
      ^white -> "W"
      _ -> "_"
    end
  end

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(%{black: {bx, by}, white: {wx,wy}})
    when bx == wx
    when by == wy
    when (bx - by) == (wx - wy)
    when (bx + by) == (wx + wy), do: true
  def can_attack?(_), do: false

end
