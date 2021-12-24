defmodule Day12 do
  def is_lower?(s), do: s != String.upcase(s)

  def frequencies(list),
    do: list |> Enum.reduce(%{}, fn x, acc -> Map.update(acc, x, 1, &(&1 + 1)) end)

  def flatten_one_level(list),
    do:
      Enum.flat_map(list, fn
        x when is_list(x) -> x
        x -> [x]
      end)

  def prefix_contains_double?(prefix) do
    prefix
    |> frequencies()
    |> Enum.map(fn {k, v} -> is_lower?(k) && v > 1 end)
    |> Enum.any?()
  end

  def paths_from(graph, v, prefix \\ []) do
    prefix = [v | prefix]

    successor_vertices =
      graph
      |> Graph.successor_vertices(v)
      |> Enum.reject(fn x -> is_lower?(x) && Enum.member?(prefix, x) end)

    next_paths =
      successor_vertices
      |> Enum.map(fn v2 ->
        paths_from(graph, v2, prefix)
      end)
      |> flatten_one_level()

    if length(next_paths) == 0 || v == "end" do
      [Enum.reverse(prefix)]
    else
      next_paths
    end
  end

  def paths_from_2(graph, v, prefix \\ []) do
    prefix = [v | prefix]

    successor_vertices = graph |> Graph.successor_vertices(v) |> List.delete("start")

    successor_vertices =
      if prefix_contains_double?(prefix) do
        successor_vertices
        |> Enum.reject(fn x -> is_lower?(x) && Enum.member?(prefix, x) end)
      else
        successor_vertices
      end

    next_paths =
      successor_vertices
      |> Enum.map(fn v2 ->
        paths_from_2(graph, v2, prefix)
      end)
      |> flatten_one_level()

    if length(next_paths) == 0 || v == "end" do
      [Enum.reverse(prefix)]
    else
      next_paths
    end
  end

  def part_1(data) do
    data
    |> Graph.new()
    |> paths_from("start")
    |> Enum.filter(fn p -> List.last(p) == "end" end)
    |> Enum.count()
  end

  def part_2(data) do
    data
    |> Graph.new()
    |> paths_from_2("start")
    |> Enum.filter(fn p -> List.last(p) == "end" end)
    |> Enum.count()
  end

  def main do
    {:ok, contents} = File.read("data/day12.txt")
    IO.inspect(contents |> part_1(), label: "part 1")
    IO.inspect(contents |> part_2(), label: "part 2")
  end
end
