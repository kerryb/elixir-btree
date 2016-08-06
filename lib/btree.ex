defmodule BTree do
  defstruct [:key, :value, :left, :right]

  def insert(tree = nil, key, value), do: %BTree{key: key, value: value}
  def insert(tree = %BTree{key: nil}, key, value), do: %{tree | key: key, value: value}
  def insert(tree = %BTree{key: key}, key, value), do: %{tree | value: value}
  def insert(tree = %BTree{key: our_key}, key, value) when key < our_key do
    %{tree | left: BTree.insert(tree.left, key, value)}
  end
  def insert(tree, key, value), do: %{tree | right: BTree.insert(tree.right, key, value)}

  def search(nil, _), do: nil
  def search(%BTree{key: key, value: value}, key), do: value
  def search(tree = %BTree{key: our_key}, key) when key < our_key, do: search tree.left, key
  def search(tree, key), do: search tree.right, key
end
