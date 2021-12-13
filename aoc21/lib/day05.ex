defmodule Day05 do
  @typedoc """
  width, height, data
  """
  @type grid_t :: %{width: integer, height: integer, data: tuple}

  @typedoc """
  x, y
  """
  @type point_t :: {integer, integer}

  @typedoc """
  start, end
  """
  @type line_t :: {point_t, point_t}

  @spec parse_point(String.t()) :: point_t
  def parse_point(s),
    do:
      s
      |> String.split(~r/\s*,\s*/, trim: true)
      |> Enum.map(&String.to_integer/1)
      |> List.to_tuple()

  @spec parse_line(String.t()) :: line_t
  def parse_line(s),
    do: s |> String.split(~r/\s*->\s*/, trim: true) |> Enum.map(&parse_point/1) |> List.to_tuple()

  @spec size_for_lines(list(line_t)) :: {number, number}
  def size_for_lines(lines) do
    Enum.reduce(lines, {0, 0}, fn {{x0, y0}, {x1, y1}}, {x, y} ->
      {Enum.max([x, x0 + 1, x1 + 1]), Enum.max([y, y0 + 1, y1 + 1])}
    end)
  end

  @spec empty_grid(number, number, any) :: grid_t
  def empty_grid(width, height, default),
    do: %{width: width, height: height, data: Tuple.duplicate(default, width * height)}

  @spec get_grid_point(grid_t, point_t) :: any
  def get_grid_point(grid, {x, y}), do: elem(grid[:data], grid[:width] * y + x)

  @spec set_grid_point(grid_t, point_t, any) :: grid_t
  def set_grid_point(grid, {x, y}, value),
    do: %{
      width: grid[:width],
      height: grid[:height],
      data: put_elem(grid[:data], grid[:width] * y + x, value)
    }

  @spec increment_grid_point(grid_t, point_t) :: grid_t
  def increment_grid_point(grid, point),
    do: set_grid_point(grid, point, get_grid_point(grid, point) + 1)

  @spec add_line_to_grid(line_t, grid_t) :: grid_t
  def add_line_to_grid({p0, p1}, grid) when elem(p0, 0) == elem(p1, 0) do
    x = elem(p0, 0)
    y_start = min(elem(p0, 1), elem(p1, 1))
    y_end = max(elem(p0, 1), elem(p1, 1))
    y_start..y_end |> Enum.reduce(grid, &increment_grid_point(&2, {x, &1}))
  end

  def add_line_to_grid({p0, p1}, grid) when elem(p0, 1) == elem(p1, 1) do
    y = elem(p0, 1)
    x_start = min(elem(p0, 0), elem(p1, 0))
    x_end = max(elem(p0, 0), elem(p1, 0))
    x_start..x_end |> Enum.reduce(grid, &increment_grid_point(&2, {&1, y}))
  end

  def add_line_to_grid({{x0, y0}, {x1, y1}}, grid) do
    step_x = if x0 < x1, do: 1, else: -1
    step_y = if y0 < y1, do: 1, else: -1

    Enum.zip([Range.new(x0, x1, step_x), Range.new(y0, y1, step_y)])
    |> Enum.reduce(grid, &increment_grid_point(&2, &1))
  end

  @spec parse_data(String.t()) :: list(line_t)
  def parse_data(contents),
    do: String.split(contents, "\n", trim: true) |> Enum.map(&parse_line/1)

  def part_1(contents) do
    lines =
      contents
      |> String.split("\n", trim: true)
      |> Enum.map(&parse_line/1)
      |> Enum.filter(fn {{x0, y0}, {x1, y1}} -> x0 == x1 || y0 == y1 end)

    {width, height} = size_for_lines(lines)
    grid = empty_grid(width, height, 0)
    grid = lines |> Enum.reduce(grid, fn line, grid -> add_line_to_grid(line, grid) end)
    grid[:data] |> Tuple.to_list() |> Enum.filter(fn n -> n > 1 end) |> length()
  end

  def part_2(contents) do
    lines =
      contents
      |> String.split("\n", trim: true)
      |> Enum.map(&parse_line/1)

    {width, height} = size_for_lines(lines)
    grid = empty_grid(width, height, 0)
    grid = lines |> Enum.reduce(grid, fn line, grid -> add_line_to_grid(line, grid) end)
    grid[:data] |> Tuple.to_list() |> Enum.filter(fn n -> n > 1 end) |> length()
  end

  def main do
    {:ok, contents} = File.read("data/day05.txt")
    IO.inspect(part_1(contents), label: "part 1")
    IO.inspect(part_2(contents), label: "part 2")
  end
end
