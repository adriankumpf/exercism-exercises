defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count(l), do: do_count(l, 0)

  defp do_count([_|t], acc), do: do_count(t, acc + 1)
  defp do_count([], acc), do: acc


  @spec reverse(list) :: list
  def reverse(list),    do: do_reverse(list, [])

  defp do_reverse([], acc),    do: acc
  defp do_reverse([h|t], acc), do: do_reverse(t, [h | acc])


  @spec map(list, (any -> any)) :: list
  def map([], _), do: []
  def map([h|t], f), do: [ f.(h) | map(t, f) ]


  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter([], _), do: []
  def filter([h|t], f) do
    if f.(h),
    do: [ h | filter(t, f) ],
    else:  filter(t, f)
  end


  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce(l, acc, f), do: do_reduce(l, acc, f)

  def do_reduce([h|t], acc, f), do: do_reduce(t, f.(h, acc), f)
  def do_reduce([], acc, _), do: acc


  @spec append(list, list) :: list
  def append([], []), do: []
  def append([], [h|t]), do: [ h | append(t, []) ]
  def append([h|t], b), do: [h | append(t,b) ]

  @spec concat([[any]]) :: [any]
  def concat([]), do: []
  def concat(ll) do
    append = &([&1|&2])

    ll
    |> reduce([], &reduce(&1, &2, append))
    |> reverse
  end
end
