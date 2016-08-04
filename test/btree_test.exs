defmodule BTreeTest do
  use ExUnit.Case
  doctest BTree

  describe "BTree, as a whole" do
    test "allows insertion and search" do
      tree = %BTree{}
              |> BTree.insert("one", 1)
              |> BTree.insert("two", 2)
              |> BTree.insert("three", 3)
      assert BTree.search(tree, "two") == 2
    end
  end

  describe "An empty BTree" do
    test "stores the first inserted value itself" do
      tree = %BTree{}
              |> BTree.insert("one", 1)
      assert {tree.key, tree.value} == {"one", 1}
    end
  end
end
