defmodule BTreeTest do
  use ExUnit.Case
  doctest BTree

  describe "BTree, as a whole" do
    test "allows insertion and search" do
      tree = %BTree{}
              |> BTree.insert("bravo", 1)
              |> BTree.insert("alpha", 2)
              |> BTree.insert("charlie", 3)
              |> BTree.insert("delta", 4)
      assert BTree.search(tree, "charlie") == 3
    end
  end

  describe "An empty BTree" do
    test "stores the first inserted value itself" do
      tree = %BTree{}
              |> BTree.insert("alpha", 1)
      assert {tree.key, tree.value} == {"alpha", 1}
    end
  end

  describe "A BTree with a value" do
    setup do
      [tree: %BTree{key: "bravo", value: 1}]
    end

    test "stores values with keys less than its own in its left node", context do
      tree = context[:tree] |> BTree.insert("alpha", 2)
      assert tree.left.key == "alpha"
    end

    test "stores values with keys greater than its own in its right node", context do
      tree = context[:tree] |> BTree.insert("charlie", 2)
      assert tree.right.key == "charlie"
    end

    test "overwrites its own value when the key matches", context do
      tree = context[:tree] |> BTree.insert("bravo", 42)
      assert tree.value == 42
    end
  end
end
