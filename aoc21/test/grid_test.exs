defmodule GridTest do
  use ExUnit.Case
  import Grid

  setup do
    {:ok,
     contents: """
     219
     485
     890
     123
     """}
  end

  test "new", %{contents: contents} do
    assert new(contents) == %{
             width: 3,
             height: 4,
             size: 12,
             data: {2, 1, 9, 4, 8, 5, 8, 9, 0, 1, 2, 3}
           }

    assert new("219 485 890  123") ==
             %{width: 3, height: 4, size: 12, data: {2, 1, 9, 4, 8, 5, 8, 9, 0, 1, 2, 3}}
  end

  test "string_to_point" do
    assert string_to_point("1,10") == {1, 10}
    assert string_to_point("   2  ,   3  ") == {2, 3}
  end

  test "point_to_position", %{contents: contents} do
    grid = new(contents)
    assert point_to_position({0, 0}, grid) == 0
    assert point_to_position({0, 1}, grid) == 3
    assert point_to_position({1, 0}, grid) == 1
    assert point_to_position({1, 2}, grid) == 7
  end

  test "position_to_point", %{contents: contents} do
    grid = new(contents)
    assert position_to_point(0, grid) == {0, 0}
    assert position_to_point(3, grid) == {0, 1}
    assert position_to_point(1, grid) == {1, 0}
    assert position_to_point(7, grid) == {1, 2}
  end

  test "get", %{contents: contents} do
    grid = new(contents)
    assert get({0, 2}, grid) == 8
    assert get({1, 0}, grid) == 1
  end

  test "put", %{contents: contents} do
    grid = new(contents)
    assert put({0, 2}, grid, 11) == %{grid | data: {2, 1, 9, 4, 8, 5, 11, 9, 0, 1, 2, 3}}
    assert put({1, 0}, grid, 99) == %{grid | data: {2, 99, 9, 4, 8, 5, 8, 9, 0, 1, 2, 3}}
  end

  test "is_valid_point?", %{contents: contents} do
    grid = new(contents)
    assert is_valid_point?({0, 0}, grid)
    assert is_valid_point?({2, 3}, grid)
    assert !is_valid_point?({-1, 0}, grid)
    assert !is_valid_point?({1, -3}, grid)
    assert !is_valid_point?({0, 4}, grid)
  end

  test "min_adjacent", %{contents: contents} do
    grid = new(contents)
    assert min_adjacent({0, 0}, grid) == 1
    assert min_adjacent({1, 2}, grid) == 0
    assert min_adjacent({0, 3}, grid) == 2
  end

  test "shrink_to", %{contents: contents} do
    assert new(contents) |> shrink_to(2, 3) == new("219 485")
    assert new(contents) |> shrink_to(2, 1) == new("2 4")
  end
end
