defmodule Day09Test do
  use ExUnit.Case
  import Day09

  setup do
    {:ok,
     contents: """
     2199943210
     3987894921
     9856789892
     8767896789
     9899965678
     """}
  end

  @tag :skip
  test "part 1", %{contents: contents} do
    assert contents |> part_1() == nil
  end

  @tag :skip
  test "part 2", %{contents: contents} do
    assert contents |> part_2() == nil
  end
end
