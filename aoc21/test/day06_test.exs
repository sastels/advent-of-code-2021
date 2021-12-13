defmodule Day06Test do
  use ExUnit.Case
  import Day06

  setup do
    {:ok, contents: "3,4,3,1,2"}
  end

  test "step_time", %{contents: contents} do
    assert [0, 1, 2, 0, 3] |> step_time() == [6, 0, 1, 6, 2, 8, 8]
  end

  test "part 1", %{contents: contents} do
    assert contents |> part_1() == 5934
  end

  @tag :skip
  test "part 2", %{contents: contents} do
    assert contents |> part_2() == 0
  end
end
