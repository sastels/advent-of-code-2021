defmodule Day05Test do
  use ExUnit.Case

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

  test "part 1", %{contents: contents} do
    assert contents |> Day05.part_1() == 5
  end

  @tag :skip
  test "part 2", %{contents: contents} do
    assert contents |> Day05.part_2() == nil
  end
end
