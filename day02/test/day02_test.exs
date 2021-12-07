defmodule Day02Test do
  use ExUnit.Case

  test "split_data() splits file into list of strings" do
    data = """
    forward 5
    down 5
    up 3
    """

    assert Day02.split_data(data) == ["forward 5", "down 5", "up 3"]
  end

  test "parse_command_string returns a command, value tuple" do
    assert "forward 5" |> Day02.parse_command_string() == {:forward, 5}
    assert "down 2" |> Day02.parse_command_string() == {:down, 2}
    assert "up 1" |> Day02.parse_command_string() == {:up, 1}
  end

  test "get_forward_value works" do
    assert {:forward, 2} |> Day02.get_forward_value() == 2
    assert {:up, 3} |> Day02.get_forward_value() == 0
    assert {:down, 4} |> Day02.get_forward_value() == 0
  end

  test "get_depth_value works" do
    assert {:forward, 2} |> Day02.get_depth_value() == 0
    assert {:up, 3} |> Day02.get_depth_value() == -3
    assert {:down, 4} |> Day02.get_depth_value() == 4
  end

  test "part_1 works on example data" do
    commands = [{:forward, 5}, {:down, 5}, {:forward, 8}, {:up, 3}, {:down, 8}, {:forward, 2}]
    assert Day02.part_1(commands) == 150
  end

  # test("part_2 works on example data") do
  #   data = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]
  #   assert Day02.part_2(data) == 5
  # end
end
