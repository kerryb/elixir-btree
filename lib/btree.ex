defmodule BTree do
  defstruct [:key, :value, :left, :right]

  def insert(tree = %BTree{key: nil}, key, value) do
    %{tree | key: key, value: value}
  end
  def insert(tree = %BTree{key: key}, key, value) do
    %{tree | value: value}
  end
  def insert(tree, key, value) do
    if key < tree.key do
      %{tree | left: %BTree{key: key, value: value}}
    else
      %{tree | right: %BTree{key: key, value: value}}
    end
  end

  def search(tree, key) do
  end
end
