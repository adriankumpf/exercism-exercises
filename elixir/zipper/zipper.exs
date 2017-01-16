defmodule BinTree do
  import Inspect.Algebra
  @moduledoc """
  A node in a binary tree.

  `value` is the value of a node.
  `left` is the left subtree (nil if no subtree).
  `right` is the right subtree (nil if no subtree).
  """
  @type t :: %BinTree{ value: any, left: BinTree.t | nil, right: BinTree.t | nil }
  defstruct value: nil, left: nil, right: nil

  # A custom inspect instance purely for the tests, this makes error messages
  # much more readable.
  #
  # BT[value: 3, left: BT[value: 5, right: BT[value: 6]]] becomes (3:(5::(6::)):)
  def inspect(%BinTree{value: v, left: l, right: r}, opts) do
    concat ["(", to_doc(v, opts),
            ":", (if l, do: to_doc(l, opts), else: ""),
            ":", (if r, do: to_doc(r, opts), else: ""),
            ")"]
  end
end

defmodule Zipper do

  alias __MODULE__, as: Z
  alias BinTree, as: BT

  @type el :: :root | {:left, BT.t} | {:right, BT.t}
  @type t  :: %Zipper{focus: BinTree.t, path: [el]}

  defstruct focus: nil, path: []

  @doc """
  Get a zipper focused on the root node.
  """
  @spec from_tree(BT.t) :: Z.t
  def from_tree(bt), do: %Z{focus: bt, path: :root}

  @doc """
  Get the complete tree from a zipper.
  """
  @spec to_tree(Z.t) :: BT.t
  def to_tree(%Z{focus: bt, path: :root}), do: bt
  def to_tree(z), do: z |> up |> to_tree

  @doc """
  Get the value of the focus node.
  """
  @spec value(Z.t) :: any
  def value(%Z{focus: bt}), do: bt.value

  @doc """
  Get the left child of the focus node, if any.
  """
  @spec left(Z.t) :: Z.t | nil
  def left(%Z{focus: %BT{left: nil}}), do: nil
  def left(%Z{focus: bt, path: p}) do
    %Z{focus: bt.left, path: [{:left, bt} | p]}
  end

  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right(Z.t) :: Z.t | nil
  def right(%Z{focus: %BT{right: nil}}), do: nil
  def right(%Z{focus: bt, path: p}) do
    %Z{focus: bt.right, path: [{:right, bt} | p]}
  end

  @doc """
  Get the parent of the focus node, if any.
  """
  @spec up(Z.t) :: Z.t
  def up(%Z{path: :root}), do: nil
  def up(%Z{focus: bt, path: [{dir, prev_bt} | p]}) do
    %Z{focus: Map.put(prev_bt, dir, bt), path: p}
  end

  @doc """
  Set the value of the focus node.
  """
  @spec set_value(Z.t, any) :: Z.t
  def set_value(z, v), do: update(z, :value, v)

  @doc """
  Replace the left child tree of the focus node.
  """
  @spec set_left(Z.t, BT.t) :: Z.t
  def set_left(z, l), do: update(z, :left, l)

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right(Z.t, BT.t) :: Z.t
  def set_right(z, r), do: update(z, :right, r)

  @spec update(Z.t, Z.el, any) :: Z.t
  defp update(%Z{focus: bt, path: p}, key, val) do
    %Z{focus: Map.put(bt, key, val), path: p}
  end

end
