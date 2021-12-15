defmodule Day07 do
  # def median(nums) do
  #   if length(nums) |> Integer.is_odd(), do: nums[length(nums) / 2]
  # else: nums[length(nums)/2]
  # end

  def parse_crabs(s),
    do:
      s
      |> String.split("\n", trim: true)
      |> Enum.at(0)
      |> String.split(~r/\s*,\s*/, trim: true)
      |> Enum.map(&String.to_integer/1)
      |> Enum.sort()

  def fuel_to_move(x, y) do
    dist = abs(x - y)
    div(dist * (dist + 1), 2)
  end

  def total_fuel(crabs, position),
    do: Enum.reduce(crabs, 0, fn x, acc -> acc + fuel_to_move(x, position) end)

  def part_1(contents) do
    crabs = parse_crabs(contents)
    best_position = Enum.at(crabs, div(length(crabs), 2))
    Enum.reduce(crabs, 0, fn x, acc -> acc + abs(x - best_position) end)
  end

  def part_2(contents) do
    crabs = parse_crabs(contents)
    position = (Enum.sum(crabs) / length(crabs)) |> round()
    f1 = total_fuel(crabs, position - 1)
    f2 = total_fuel(crabs, position)
    f3 = total_fuel(crabs, position + 1)
    Enum.min([f1, f2, f3])
  end

  def main do
    {:ok, contents} = File.read("data/day07.txt")
    IO.inspect(contents |> part_1(), label: "part 1")
    IO.inspect(contents |> part_2(), label: "part 2")
  end
end
