defmodule Day15 do
  @infinity 1_000_000

  def init(data) do
    weights = Grid.new(data)
    visited = %{}

    not_visited =
      Range.new(0, weights.size - 1)
      |> Enum.map(fn n -> {n, @infinity} end)
      |> Map.new()

    {weights, visited, not_visited}
  end

  def find_next_vertex(not_visited) do
    not_visited
    |> Enum.min_by(&elem(&1, 1))
  end

  def iterate({weights, visited, not_visited}) do
    {vertex, vertex_distance} = find_next_vertex(not_visited)

    visited = Map.put(visited, vertex, vertex_distance)
    not_visited = Map.delete(not_visited, vertex)

    not_visited =
      vertex
      |> Grid.get_adjacent_positions(weights)
      |> Enum.filter(&Map.has_key?(not_visited, &1))
      |> Enum.reduce(not_visited, fn v, not_visited ->
        Map.update!(not_visited, v, fn v_distance ->
          v_weight = Grid.get(weights, v)

          min(vertex_distance + v_weight, v_distance)
        end)
      end)

    {weights, visited, not_visited}
  end

  def find_path({w, v, nv}, from, to) do
    nv = %{nv | from => 0}
    find_path({w, v, nv}, to)
  end

  def find_path({w, v, nv}, to) do
    if Map.has_key?(v, to) do
      {w, v, nv}
    else
      {w, v, nv} = iterate({w, v, nv})
      find_path({w, v, nv}, to)
    end
  end

  def part_1(contents) do
    {w, v, nv} = init(contents)
    {_w, v, _nv} = {w, v, nv} |> find_path(0, w.size - 1)
    v[w.size - 1]
  end

  def part_2(contents) do
    contents
  end

  def main do
    {:ok, contents} = File.read("data/day15.txt")
    IO.inspect(contents |> part_1(), label: "part 1")
    # IO.inspect(contents |> part_2(), label: "part 2")
  end
end
