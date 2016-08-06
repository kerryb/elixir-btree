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

  describe "Inserting into a nil tree" do
    test "returns a new tree" do
      tree = BTree.insert nil, "alpha", 1
      assert {tree.key, tree.value} == {"alpha", 1}
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

  describe "A BTree with child nodes" do
    test "delegates insertion to the child" do
      tree = %BTree{key: "alpha", value: 1, right: %BTree{key: "charlie", value: 2}}
              |> BTree.insert("bravo", 3)
      assert tree.right.left.key == "bravo"
    end
  end

  describe "Searching" do
    test "returns the value if the key matches" do
      tree = %BTree{key: "alpha", value: 1}
      assert BTree.search(tree, "alpha") == 1
    end

    test "looks in the left node if the key is less than the node's key" do
      tree = %BTree{key: "bravo", value: 1, left: %BTree{key: "alpha", value: 2}}
      assert BTree.search(tree, "alpha") == 2
    end

    test "looks in the right node if the key is greater than the node's key" do
      tree = %BTree{key: "bravo", value: 1, right: %BTree{key: "charlie", value: 2}}
      assert BTree.search(tree, "charlie") == 2
    end

    test "returns nil if the key is not found" do
      tree = %BTree{key: "alpha", value: 1}
      assert BTree.search(tree, "bravo") == nil
    end
  end

  describe "Deleting" do
    test "removes the key and value for a root node with no children" do
      tree = %BTree{key: "alpha", value: 1}
              |> BTree.delete("alpha")
      assert tree == %BTree{}
    end

    test "does nothing if the tree is empty" do
      tree = %BTree{}
              |> BTree.delete("alpha")
      assert tree == %BTree{}
    end

    test "does nothing if the key is not found" do
      tree = %BTree{key: "alpha", value: 1}
              |> BTree.delete("bravo")
      assert tree == %BTree{key: "alpha", value: 1}
    end

    test "replaces the node with its left child if it has no right child" do
      tree = %BTree{key: "alpha", value: 1, left: %BTree{key: "bravo", value: 2}}
              |> BTree.delete("alpha")
      assert tree == %BTree{key: "bravo", value: 2}
    end
  end
end
