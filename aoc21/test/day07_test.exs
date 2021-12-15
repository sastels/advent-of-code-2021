defmodule Day07Test do
  use ExUnit.Case
  import Day07

  setup do
    {:ok, contents: "16,1,2,0,4,2,7,1,2,14"}
  end

  test "part 1", %{contents: contents} do
    assert contents |> part_1() == 37
  end

  @tag :skip
  test "part 2", %{contents: contents} do
    assert contents |> part_2() == nil
  end
end
