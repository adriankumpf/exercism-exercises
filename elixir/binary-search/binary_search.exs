defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(n, key), do: do_search(n, key, 0, tuple_size(n) - 1)

  defp do_search(_, _, from, to) when from > to, do: :not_found
  defp do_search(n, key, from, to) do
    index = div(from + to, 2)
    middle = elem(n, index)

    cond do
      middle > key -> do_search(n, key, from, index - 1)
      middle < key -> do_search(n, key, index + 1, to)
      true -> {:ok, index}
    end
  end

end
