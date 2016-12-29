defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """

  def compare(a, b) do
    cond do
      equal?(a,b) -> :equal
      sublist?(a,b) -> :sublist
      sublist?(b,a) -> :superlist
      true -> :unequal
    end
  end

  def sublist?([], _), do: true
  def sublist?(a, b), do: a in Stream.chunk(b, length(a), 1)

  def equal?(a, b), do: a === b

end
