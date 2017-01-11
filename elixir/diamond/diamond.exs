defmodule Diamond do
  @doc """
  Given a letter, it prints a diamond starting with 'A',
  with the supplied letter at the widest point.
  """
  @spec build_shape(char) :: String.t
  def build_shape(letter) do
    letter
    |> diamond_letters
    |> create_diamond
  end

  defp diamond_letters(letter) do
    range = ?A..letter
    Enum.to_list(range) ++ (range |> Enum.reverse |> Enum.drop(1))
  end

  defp create_diamond(letters) do
    size = Enum.count(letters)

    letters
    |> Enum.map(&create_line(&1, size))
    |> Enum.join
  end

  defp create_line(letter, size) do
    pos = div(size, 2) - letter + ?A

    List.duplicate(" ", size)
    |> List.replace_at(pos, letter)
    |> List.replace_at(size - pos - 1, letter)
    |> List.insert_at(-1, "\n")
  end

end
