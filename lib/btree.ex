defmodule BTree do
  defstruct [:key, :value, :left, :right]

  def insert(tree = nil, key, value), do: %BTree{key: key, value: value}
  def insert(tree = %BTree{key: nil}, key, value), do: %{tree | key: key, value: value}
  def insert(tree = %BTree{key: key}, key, value), do: %{tree | value: value}
  def insert(tree, key, value) do
    if key < tree.key do
      %{tree | left: BTree.insert(tree.left, key, value)}
    else
      %{tree | right: BTree.insert(tree.right, key, value)}
    end
  end

  def search(nil, _), do: nil
  def search(%BTree{key: key, value: value}, key), do: value
  def search(tree, key) do
    if key < tree.key do
      search tree.left, key
    else
      search tree.right, key
    end
  end
end
