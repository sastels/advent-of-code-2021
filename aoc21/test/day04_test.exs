defmodule Day04Test do
  use ExUnit.Case

  setup do
    {:ok,
     contents: """
     7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

     22 13 17 11  0
     8  2 23  4 24
     21  9 14 16  7
     6 10  3 18  5
     1 12 20 15 19

     3 15  0  2 22
     9 18 13 17  5
     19  8  7 25 23
     20 11 10 24  4
     14 21 16 12  6

     14 21 17 24  4
     10 16 15  9 19
     18  8 23 26 20
     22 11 13  6  5
     2  0 12  3  7
     """}
  end

  test "mark_board" do
    r = [1, 2, 3, 4, 5]
    r_m = [1, :marked, 3, 4, 5]
    r2 = [11, 22, 33, 2, 55]
    r2_m = [11, 22, 33, :marked, 55]
    b1 = Enum.concat([r, r2, r, r, r2])
    b1_m = Enum.concat([r_m, r2_m, r_m, r_m, r2_m])
    assert Day04.mark_board(2, b1) == b1_m
  end

  test "mark_boards" do
    r = [1, 2, 3, 4, 5]
    r_m = [1, :marked, 3, 4, 5]
    r2 = [11, 22, 33, 2, 55]
    r2_m = [11, 22, 33, :marked, 55]
    b1 = Enum.concat([r, r2, r, r, r2])
    b1_m = Enum.concat([r_m, r2_m, r_m, r_m, r2_m])
    b2 = Enum.concat([r2, r2, r, r2, r])
    b2_m = Enum.concat([r2_m, r2_m, r_m, r2_m, r_m])
    assert Day04.mark_boards(2, [b1, b2]) == [b1_m, b2_m]
  end

  test "row_marked" do
    row = [1, 2, 3, 4, 5]
    marked = [:marked, :marked, :marked, :marked, :marked]
    b1 = Enum.concat([marked, row, marked, row, row])
    assert !Day04.row_marked?(1, b1)

    b2 = Enum.concat([row, marked, row, row, row])
    assert Day04.row_marked?(1, b2)
  end

  test "col_marked" do
    row = [1, 2, 3, 4, 5]
    board = Enum.concat([row, row, row, row, row])
    assert !Day04.col_marked?(3, board)

    row = [1, 2, 3, :marked, 5]
    board = Enum.concat([row, row, row, row, row])
    assert Day04.col_marked?(3, board)
  end

  test "is_winning_board nope" do
    row = [1, 2, 3, 4, 5]
    board = Enum.concat([row, row, row, row, row])
    assert !Day04.is_winning_board?(board)
  end

  test "is_winning_board row" do
    row = [1, 2, 3, 4, 5]
    marked = [:marked, :marked, :marked, :marked, :marked]
    board = Enum.concat([row, row, row, marked, row])
    assert Day04.is_winning_board?(board)
  end

  test "is_winning_board col" do
    row = [1, :marked, 3, 4, 5]
    board = Enum.concat([row, row, row, row, row])
    assert Day04.is_winning_board?(board)
  end

  test "part 1", %{contents: contents} do
    assert contents |> Day04.part_1() == 4512
  end

  test "part 2", %{contents: contents} do
    assert contents |> Day04.part_2() == 1924
  end
end
