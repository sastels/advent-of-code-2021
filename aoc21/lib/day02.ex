# useful:
# iex -S mix
# recompile()

defmodule Day02 do
  def split_data(data) do
    String.split(data, "\n", trim: true)
  end

  def parse_command_string(s) do
    [s0, s1] = String.split(s)
    {value, _} = Integer.parse(s1)

    cond do
      s0 == "forward" -> {:forward, value}
      s0 == "up" -> {:up, value}
      s0 == "down" -> {:down, value}
    end
  end

  def get_forward_value({:forward, value}), do: value
  def get_forward_value({_, _}), do: 0

  def get_depth_value({:down, value}), do: value
  def get_depth_value({:up, value}), do: -value
  def get_depth_value({_, _}), do: 0

  def part_1(commands) do
    forward =
      commands
      |> Enum.map(&get_forward_value/1)
      |> Enum.sum()

    depth =
      commands
      |> Enum.map(&get_depth_value/1)
      |> Enum.sum()

    forward * depth
  end

  def apply_command({:down, x}, {horiz, depth, aim}), do: {horiz, depth, aim + x}
  def apply_command({:up, x}, {horiz, depth, aim}), do: {horiz, depth, aim - x}
  def apply_command({:forward, x}, {horiz, depth, aim}), do: {horiz + x, depth + aim * x, aim}

  def part_2(commands) do
    {horizontal, depth, _} = Enum.reduce(commands, {0, 0, 0}, &apply_command/2)
    horizontal * depth
  end

  def main do
    {:ok, contents} = File.read("data/day02.txt")
    commands = contents |> split_data() |> Enum.map(&parse_command_string/1)

    IO.inspect(part_1(commands), label: "part 1")
    IO.inspect(part_2(commands), label: "part 2")
  end
end
