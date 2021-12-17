defmodule Day08Test do
  use ExUnit.Case
  import Day08

  setup do
    {:ok, contents: "hi there"}
  end

  @tag :skip
  test "part 1", %{contents: contents} do
    assert contents |> part_1() == nil
  end

  @tag :skip
  test "part 2", %{contents: contents} do
    assert contents |> part_2() == nil
  end
end
