defmodule Day18 do
  @type pair_t :: %{id: String.t(), parent: String.t(), left: term, right: term}

  def new(sys) do
    id = UUID.uuid4()
    Map.put(sys, id, %{id: id, parent: nil, left: nil, right: nil})
  end

  def part_1(contents) do
    contents
  end

  def part_2(contents) do
    contents
  end

  def main do
    {:ok, contents} = File.read("data/day18.txt")
    IO.inspect(contents |> part_1(), label: "part 1")
    # IO.inspect(contents |> part_2(), label: "part 2")
  end
end
