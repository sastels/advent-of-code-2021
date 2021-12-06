# useful:
# iex -S mix
# recompile()

defmodule Day01 do
  def split_data(data) do
    String.split(data)
    |> Enum.map(fn s -> Integer.parse(s) |> elem(0) end)
  end

  def sum_three(list1) do
    [_ | list2] = list1
    [_ | list3] = list2

    Enum.zip([list1, list2, list3])
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&Enum.sum(&1))
  end

  def num_increases(list1) do
    [_ | list2] = list1

    Enum.zip(list1, list2)
    |> Enum.filter(&(elem(&1, 1) > elem(&1, 0)))
    |> length()
  end

  def part_1(data) do
    data |> num_increases
  end

  def part_2(data) do
    data |> sum_three |> num_increases
  end

  def main do
    {:ok, contents} = File.read("data/day01.txt")
    data = split_data(contents)

    IO.inspect(part_1(data), label: "part 1")
    IO.inspect(part_2(data), label: "part 2")
  end
end
