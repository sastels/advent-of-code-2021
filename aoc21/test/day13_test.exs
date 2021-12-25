defmodule Day13Test do
  use ExUnit.Case
  import Day13

  setup do
    {:ok,
     contents: """
     6,10
     0,14
     9,10
     0,3
     10,4
     4,11
     6,0
     6,12
     4,1
     0,13
     10,12
     3,4
     3,0
     8,4
     1,10
     2,14
     8,10
     9,0

     fold along y=7
     fold along x=5
     """}
  end

  # @tag :skip
  # test "part 1", %{contents: contents} do
  #   assert contents |> part_1() == nil
  # end

  # @tag :skip
  # test "part 2", %{contents: contents} do
  #   assert contents |> part_2() == nil
  # end
end
