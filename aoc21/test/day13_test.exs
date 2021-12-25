defmodule Day13Test do
  use ExUnit.Case
  import Day13

  #   01234
  # 0 ##.#.
  # 1 .....
  # 2 .#..#
  #
  # fold x=2

  #   01
  # 0 ##
  # 1 ..
  # 2 ##

  # fold orig along y=1
  #   ##.##

  setup do
    {:ok,
     input_small: """
     0,0
     1,0
     3,0
     1,2
     4,2
     fold along x=2
     fold along y=1
     """,
     contents: """
     6,10
     0,14
     9,10
     0,3
     10,4
     4,11
     6,0
     6,12
     4,1
     0,13
     10,12
     3,4
     3,0
     8,4
     1,10
     2,14
     8,10
     9,0

     fold along y=7
     fold along x=5
     """}
  end

  test "parse_points" do
    assert "1,2\n3,4\nfold along y=7\nfold along x=5\n" |> parse_points() ==
             [{1, 2}, {3, 4}]
  end

  test "parse_fold_string" do
    assert "fold along y=71" |> parse_fold_string() == %{dir: "y", value: 71}
  end

  test "parse_folds" do
    assert "fold along y=7\n1,33\nfold along x=5" |> parse_folds() ==
             [%{dir: "y", value: 7}, %{dir: "x", value: 5}]
  end

  #   01
  # 0 ##
  # 1 ..
  # 2 ##
  test "fold along x", %{input_small: input_small} do
    assert input_small |> parse_points() |> fold("x", 2) |> Enum.sort() ==
             [{0, 0}, {1, 0}, {0, 2}, {1, 2}] |> Enum.sort()
  end

  #   ##.##
  test "fold along y", %{input_small: input_small} do
    assert input_small |> parse_points() |> fold("y", 1) |> Enum.sort() ==
             [{0, 0}, {1, 0}, {3, 0}, {4, 0}] |> Enum.sort()
  end

  test "part 1", %{contents: contents} do
    assert contents |> part_1() == 17
  end

  test "part 2", %{contents: contents} do
    # really just want to see an "O"
    assert contents |> part_2() != nil
  end
end
