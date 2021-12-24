defmodule Day12 do
  def flatten_one_level(list),
    do:
      Enum.flat_map(list, fn
        x when is_list(x) -> x
        x -> [x]
      end)

  def paths_from(graph, v) do
    successor_vertices = Graph.successor_vertices(graph, v)
    graph = if v != String.upcase(v), do: Graph.delete_vertex(graph, v), else: graph

    next_paths =
      successor_vertices
      |> Enum.map(fn v2 ->
        paths_from(graph, v2)
      end)
      |> flatten_one_level()

    if length(next_paths) == 0 || v == "end" do
      [[v]]
    else
      next_paths |> Enum.map(fn p -> [v | p] end)
    end
  end

  def part_1(data) do
    data
    |> Graph.new()
    |> paths_from("start")
    |> Enum.filter(fn p -> List.last(p) == "end" end)
    |> Enum.count()
  end

  def part_2(contents) do
    contents
  end

  def main do
    {:ok, contents} = File.read("data/day12.txt")
    IO.inspect(contents |> part_1(), label: "part 1")
    # IO.inspect(contents |> part_2(), label: "part 2")
  end
end
