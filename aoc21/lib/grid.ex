defmodule Grid do
  @type grid_t :: %{width: integer, height: integer, data: tuple()}
  @type point_t :: {integer, integer}

  @spec new(String.t()) :: grid_t
  def new(contents) do
    lines = contents |> String.split("\n", trim: true)
    width = String.length(Enum.at(lines, 0))
    height = length(lines)

    data =
      lines
      |> Enum.join()
      |> String.graphemes()
      |> Enum.map(&String.to_integer/1)
      |> List.to_tuple()

    %{width: width, height: height, data: data}
  end

  @spec point_to_position(point_t, grid_t) :: integer
  def point_to_position({x, y}, grid), do: grid[:width] * y + x

  @spec position_to_point(integer, grid_t) :: point_t
  def position_to_point(n, grid), do: {rem(n, grid[:width]), div(n, grid[:width])}

  @spec get(point_t, grid_t) :: any
  def get({x, y}, grid), do: elem(grid[:data], point_to_position({x, y}, grid))

  @spec put(point_t, grid_t, any) :: any
  def put({x, y}, grid, value),
    do: %{grid | data: put_elem(grid[:data], point_to_position({x, y}, grid), value)}

  def is_valid_point?({x, y}, grid) do
    x >= 0 && x < grid[:width] && y >= 0 && y < grid[:height]
  end

  def get_adjacent({x, y}, grid) do
    [{x - 1, y}, {x + 1, y}, {x, y - 1}, {x, y + 1}]
    |> Enum.filter(&is_valid_point?(&1, grid))
  end

  def get_all_points(grid) do
    Range.new(0, grid[:width] * grid[:height] - 1)
    |> Enum.map(&position_to_point(&1, grid))
  end

  @spec min_adjacent(point_t, grid_t) :: any
  def min_adjacent(p, grid) do
    get_adjacent(p, grid)
    |> Enum.map(&get(&1, grid))
    |> Enum.min()
  end

  def inspect(grid) do
    grid[:data]
    |> Tuple.to_list()
    |> Enum.with_index()
    |> Enum.each(fn {x, index} ->
      if rem(index, grid[:width]) == 0, do: IO.write("\n")
      IO.write(x)
      IO.write(" ")
    end)

    grid
  end
end
