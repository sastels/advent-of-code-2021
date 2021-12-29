defmodule Day15Test do
  use ExUnit.Case
  import Day15

  setup do
    {:ok,
     contents: """
     1163751742
     1381373672
     2136511328
     3694931569
     7463417111
     1319128137
     1359912421
     3125421639
     1293138521
     2311944581
     """}
  end

  test "iterate" do
    data = """
    123
    456
    """

    w = Grid.new(data)
    nv = %{0 => 0}
    {w, v, nv} = {w, %{}, nv} |> iterate()
    assert v == %{0 => 0}
    assert nv[1] == 2
    assert nv[3] == 4

    {_w, v, nv} = {w, v, nv} |> iterate()
    assert v == %{0 => 0, 1 => 2}
    assert nv[2] == 5
    assert nv[4] == 7
  end

  test "part 1", %{contents: contents} do
    assert contents |> part_1() == 40
  end

  test "part 2", %{contents: contents} do
    assert contents |> part_2() == 315
  end
end
