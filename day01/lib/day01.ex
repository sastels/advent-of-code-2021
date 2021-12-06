# iex -S mix
# recompile()

defmodule Day01 do
  def split_data(data) do
    readings = String.split(data)
    Enum.map(readings, fn s -> Integer.parse(s) |> elem(0) end)
  end

  def part_1(data) do
    [first | list2] = data
    list1 = List.delete_at(data, length(data) - 1)

    Enum.zip(list1, list2)
    |> Enum.map(&(elem(&1, 1) > elem(&1, 0)))
    |> Enum.filter(& &1)
    |> length()
  end

  def main do
    {:ok, contents} = File.read("data/day01.txt")
    data = split_data(contents)
    IO.inspect(part_1(data), label: "part 1")
  end
end
