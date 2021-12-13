defmodule Day06Test do
  use ExUnit.Case
  import Day06

  setup do
    {:ok,
     contents: """
     3,4,3,1,2
     """}
  end

  @tag :skip
  test "part 1", %{contents: contents} do
    assert contents |> Day06.part_1() == 5934
  end

  @tag :skip
  test "part 2", %{contents: contents} do
    assert contents |> Day06.part_2() == 0
  end
end
