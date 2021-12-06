defmodule Day01Test do
  use ExUnit.Case

  test "split_data() splits a string and returns a list of ints" do
    data = """
    199
    200
    208
    210
    """

    assert Day01.split_data(data) == [199, 200, 208, 210]
  end

  test "part_1 works on example data" do
    data = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]
    assert Day01.part_1(data) == 7
  end
end
