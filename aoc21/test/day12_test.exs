defmodule Day12Test do
  use ExUnit.Case
  import Day12

  setup do
    {:ok,
     data_small: """
     start-A
     start-b
     A-c
     A-b
     b-d
     A-end
     b-end
     """,
     data_big: """
     fs-end
     he-DX
     fs-he
     start-DX
     pj-DX
     end-zg
     zg-sl
     zg-pj
     pj-he
     RW-he
     fs-DX
     pj-RW
     zg-RW
     start-pj
     he-WI
     zg-he
     pj-fs
     start-RW
     """}
  end

  test "paths_from one edge" do
    assert Graph.new("a-b") |> paths_from("a") == [["a", "b"]]
  end

  test "paths_from two edge" do
    assert Graph.new("a-b b-c") |> paths_from("a") == [["a", "b", "c"]]
  end

  test "paths_from more complicated" do
    assert Graph.new("a-b b-c b-d ") |> paths_from("a") ==
             [["a", "b", "c"], ["a", "b", "d"]]
  end

  test "part 1 small", %{data_small: data_small} do
    assert data_small |> part_1() == 10
  end

  test "part 1 big", %{data_big: data_big} do
    assert data_big |> part_1() == 226
  end

  test "part 2 small", %{data_small: data_small} do
    assert data_small |> part_2() == 36
  end

  test "part 2 big", %{data_big: data_big} do
    assert data_big |> part_2() == 3509
  end
end
