defmodule SnailTest do
  use ExUnit.Case
  import Snail

  setup do
    {:ok,
     contents: """
     hi there
     """}
  end

  test "find_commas" do
    assert find_commas("[1,2]") == [2]
    assert find_commas("[9,[8,7]]") == [2, 5]
  end

  test "parse" do
    assert parse(%{}, "4") == {%{}, 4}
    {sys, id} = parse(%{}, "[1,2]")

    assert sys ==
             %{id => %Snail{id: id, parent: "", left: 1, right: 2}}
  end

  test "parse complicated" do
    {sys, id} = parse(%{}, "[[1,2],3]")

    root = sys[id]
    assert root.right == 3
    left = sys[root.left]
    assert left.parent == id
    assert left.left == 1
    assert left.right == 2
  end

  test "parse complicated 2" do
    {sys, id} = parse(%{}, "[9,[8,7]]")

    root = sys[id]
    assert root.left == 9
    right = sys[root.right]
    assert right.parent == id
    assert right.left == 8
    assert right.right == 7
  end

  test "to_string" do
    {sys, id} = parse(%{}, "3")
    assert to_string(sys, id) == "3"
    {sys, id} = parse(%{}, "[1,2]")
    assert to_string(sys, id) == "[1,2]"
    {sys, id} = parse(%{}, "[9,[8,7]]")
    assert to_string(sys, id) == "[9,[8,7]]"
    {sys, id} = parse(%{}, "[[1,2],[3,4]]")
    assert to_string(sys, id) == "[[1,2],[3,4]]"
  end

  test "add" do
    sys = %{}
    {sys, s0} = parse(sys, "[1,2]")
    {sys, s1} = parse(sys, "[3,4]")
    {sys, sum} = add(sys, s0, s1)
    assert to_string(sys, sum) == "[[1,2],[3,4]]"
  end

  @tag :skip
  test "find_first_4_deep" do
    {sys, root} = parse(%{}, "[1,[3,4]]")
    assert find_first_4_deep(sys, root, 0) == nil
    assert find_first_4_deep(sys, root, 4) == root
    lev1 = find_first_4_deep(sys, root, 3)
    assert to_string(sys, lev1) == "[3,4]"
  end

  test "find_first_4_deep full" do
    {sys, root} = parse(%{}, "[1,[[11,[31,[9,10]]],4]]")
    lev1 = find_first_4_deep(sys, root, 0)
    assert to_string(sys, lev1) == "[9,10]"
  end
end
