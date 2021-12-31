defmodule Day17Test do
  use ExUnit.Case
  import Day17

  test "part 2" do
    target = %{x_min: 20, x_max: 30, y_min: -10, y_max: -5}
    assert target |> part_2() == 112
  end
end
