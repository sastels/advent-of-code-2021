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

  test "get_low_points", %{contents: contents} do
    assert contents |> Grid.new() |> get_low_points() ==
             [{1, 0}, {9, 0}, {2, 2}, {6, 4}]
  end

  test "part 1", %{contents: contents} do
    assert contents |> part_1() == 15
  end

  test "part 2", %{contents: contents} do
    assert contents |> part_2() == 1134
  end
end
