defmodule Day05Test do
  use ExUnit.Case
  import Day05

  setup do
    {:ok,
     contents: """
     0,9 -> 5,9
     8,0 -> 0,8
     9,4 -> 3,4
     2,2 -> 2,1
     7,0 -> 7,4
     6,4 -> 2,0
     0,9 -> 2,9
     3,4 -> 1,4
     0,0 -> 8,8
     5,5 -> 8,2
     """}
  end

  test "parse_point" do
    assert parse_point("103,-229") == {103, -229}
  end

  test "parse_line" do
    assert "0,9 -> 5,9" |> parse_line() == {{0, 9}, {5, 9}}
  end

  test "empty_grid" do
    assert empty_grid(2, 3, 0) == %{width: 2, height: 3, data: {0, 0, 0, 0, 0, 0}}
  end

  test "parse_data" do
    assert parse_data("0,9 -> 5,9\n8,0 -> 0,8") == [{{0, 9}, {5, 9}}, {{8, 0}, {0, 8}}]
  end

  test "get_grid_point" do
    grid = %{width: 2, height: 3, data: {1, 2, 3, 4, 5, 6}}
    assert get_grid_point(grid, {1, 0}) == 2
    assert get_grid_point(grid, {0, 1}) == 3
    assert get_grid_point(grid, {1, 2}) == 6
  end

  test "set_grid_point" do
    grid = %{width: 2, height: 3, data: {1, 2, 3, 4, 5, 6}}
    assert set_grid_point(grid, {0, 1}, 33) == %{width: 2, height: 3, data: {1, 2, 33, 4, 5, 6}}
    assert set_grid_point(grid, {1, 2}, 66) == %{width: 2, height: 3, data: {1, 2, 3, 4, 5, 66}}
  end

  test "add_line_to_grid vertical" do
    grid = %{width: 2, height: 3, data: {1, 2, 3, 4, 5, 6}}
    line = {{1, 0}, {1, 1}}
    assert add_line_to_grid(line, grid)[:data] == {1, 3, 3, 5, 5, 6}
  end

  test "add_line_to_grid horizontal" do
    grid = %{width: 2, height: 3, data: {1, 2, 3, 4, 5, 6}}
    line = {{0, 1}, {1, 1}}
    assert add_line_to_grid(line, grid)[:data] == {1, 2, 4, 5, 5, 6}
  end

  test "add_line_to_grid diagonal" do
    grid = %{width: 2, height: 3, data: {1, 2, 3, 4, 5, 6}}
    assert add_line_to_grid({{0, 0}, {1, 1}}, grid)[:data] == {2, 2, 3, 5, 5, 6}
    assert add_line_to_grid({{1, 1}, {0, 0}}, grid)[:data] == {2, 2, 3, 5, 5, 6}
  end

  test "size_for_lines" do
    lines = [
      {{0, 9}, {5, 9}},
      {{8, 0}, {0, 8}}
    ]

    assert size_for_lines(lines) == {9, 10}
  end

  test "part 1", %{contents: contents} do
    assert contents |> Day05.part_1() == 5
  end

  test "part 2", %{contents: contents} do
    assert contents |> Day05.part_2() == 12
  end
end
