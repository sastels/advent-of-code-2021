defmodule Day11Test do
  use ExUnit.Case
  import Day11

  setup do
    {:ok,
     contents: """
     5483143223
     2745854711
     5264556173
     6141336146
     6357385478
     4167524645
     2176841721
     6882881134
     4846848554
     5283751526
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
