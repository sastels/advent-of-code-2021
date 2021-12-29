defmodule Day15 do
  def find_next_vertex(not_visited) do
    not_visited |> Enum.min_by(&elem(&1, 1))
  end

  def iterate({weights, visited, not_visited}) do
    {vertex, vertex_distance} = find_next_vertex(not_visited)

    visited = Map.put(visited, vertex, vertex_distance)
    not_visited = Map.delete(not_visited, vertex)

    not_visited =
      vertex
      |> Grid.get_adjacent_positions(weights)
      |> Enum.reject(&Map.has_key?(visited, &1))
      |> Enum.reduce(not_visited, fn v, not_visited ->
        v_weight = Grid.get(weights, v)

        Map.update(not_visited, v, vertex_distance + v_weight, fn v_distance ->
          min(vertex_distance + v_weight, v_distance)
        end)
      end)

    {weights, visited, not_visited}
  end

  def find_path({w, v, nv}, from, to) do
    nv = Map.put(nv, from, 0)
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

  def build_entire_cave(w) do
    cave = Grid.new(w.width * 5, w.height * 5)

    cave
    |> Grid.get_all_points()
    |> Enum.reduce(cave, fn {x, y}, cave ->
      tile_x = div(x, w.width)
      w_x = rem(x, w.width)
      tile_y = div(y, w.height)
      w_y = rem(y, w.height)
      w_val = Grid.get({w_x, w_y}, w)
      cave_val = w_val + tile_x + tile_y
      cave_val = if cave_val > 9, do: cave_val - 9, else: cave_val
      Grid.put({x, y}, cave, cave_val)
    end)
  end

  def part_1(contents) do
    w = Grid.new(contents)
    {_w, v, _nv} = {w, %{}, %{}} |> find_path(0, w.size - 1)
    v[w.size - 1]
  end

  @spec part_2(binary) :: nil | maybe_improper_list | map
  def part_2(contents) do
    w = Grid.new(contents)
    w = w |> build_entire_cave()
    {_w, v, _nv} = {w, %{}, %{}} |> find_path(0, w.size - 1)
    v[w.size - 1]
  end

  def main do
    {:ok, contents} = File.read("data/day15.txt")
    IO.inspect(contents |> part_1(), label: "part 1")
    IO.inspect(contents |> part_2(), label: "part 2")
  end
end
