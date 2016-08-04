defmodule BTree do
  defstruct [:key, :value, :left, :right]

  def insert(tree, key, value) do
    %{tree | key: key, value: value}
  end

  def search(tree, key) do
  end
end
