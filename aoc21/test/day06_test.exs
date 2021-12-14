defmodule Day06Test do
  use ExUnit.Case
  import Day06

  setup do
    {:ok, contents: "3,4,3,1,2"}
  end

  test "step_time" do
    assert [0, 1, 2, 0, 3] |> step_time() == [6, 0, 1, 6, 2, 8, 8]
  end

  test "parse_fish_map" do
    assert "0, 1, 2, 0, 3\n" |> parse_fish_map() == %{0 => 2, 1 => 1, 2 => 1, 3 => 1}
  end

  test "step_fish_map" do
    assert %{0 => 2, 3 => 2, 2 => 10} |> step_fish_map() == %{
             0 => 0,
             1 => 10,
             2 => 2,
             3 => 0,
             4 => 0,
             5 => 0,
             6 => 2,
             7 => 0,
             8 => 2
           }
  end

  test "part 1", %{contents: contents} do
    assert contents |> part_1() == 5934
  end

  @tag :skip
  test "part 2", %{contents: contents} do
    assert contents |> part_2() == 0
  end
end
