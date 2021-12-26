defmodule Day14Test do
  use ExUnit.Case
  import Day14

  setup do
    {:ok,
     contents: """
     NNCB

     CH -> B
     HH -> N
     CB -> H
     NH -> C
     HB -> C
     HC -> B
     HN -> C
     NN -> C
     BH -> H
     NC -> B
     NB -> B
     BN -> B
     BB -> N
     BC -> B
     CC -> N
     CN -> C
     """}
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
