defmodule Day06 do
  @spec step_time(list(number)) :: list(number)
  def step_time(fish) do
    num_new_fish = fish |> Enum.filter(fn x -> x == 0 end) |> Enum.count()

    fish =
      fish
      |> Enum.map(fn x -> if x > 0, do: x - 1, else: 6 end)

    fish ++ List.duplicate(8, num_new_fish)
  end

  def part_1(contents) do
    fish = contents |> String.split(~r/\s*,\a*/, trim: true) |> Enum.map(&String.to_integer/1)

    1..80
    |> Enum.reduce(fish, fn _, state -> step_time(state) end)
    |> Enum.count()
  end

  def part_2(contents) do
    contents
    |> String.split("\n", trim: true)
  end

  def main do
    {:ok, contents} = File.read("data/day06.txt")

    IO.inspect(contents |> String.split("\n", trim: true) |> Enum.at(0) |> part_1(),
      label: "part 1"
    )

    # IO.inspect(part_2(contents), label: "part 2")
  end
end
