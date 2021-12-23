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

  test "increment_levels" do
    assert Grid.new("111\n222") |> increment_levels() ==
             %{width: 3, height: 2, data: {2, 2, 2, 3, 3, 3}}
  end

  test "octo_step" do
    contents = """
    11111
    19991
    19191
    19991
    11111
    """

    expected = """
    34543
    40004
    50005
    40004
    34543
    """

    assert contents |> Grid.new() |> octo_step() == Grid.new(expected)
  end

  test "octo_step_twice", %{contents: contents} do
    expected = """
    8807476555
    5089087054
    8597889608
    8485769600
    8700908800
    6600088989
    6800005943
    0000007456
    9000000876
    8700006848
    """

    assert contents |> Grid.new() |> octo_step() |> octo_step() == Grid.new(expected)
  end

  test "part 1", %{contents: contents} do
    assert contents |> part_1() == 1656
  end

  test "part 2", %{contents: contents} do
    assert contents |> part_2() == 195
  end
end
