defmodule Day15Test do
  use ExUnit.Case
  import Day15

  setup do
    {:ok,
     contents: """
     1163751742
     1381373672
     2136511328
     3694931569
     7463417111
     1319128137
     1359912421
     3125421639
     1293138521
     2311944581
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
