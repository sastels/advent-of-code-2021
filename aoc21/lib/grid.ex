defmodule Grid do
  @type grid_t :: %{width: integer, data: tuple()}
  @type point_t :: {integer, integer}

  @spec new(String.t()) :: grid_t
  def new(contents) do
    lines = contents |> String.split("\n", trim: true)
    width = String.length(Enum.at(lines, 0))

    data =
      lines
      |> Enum.join()
      |> String.graphemes()
      |> Enum.map(&String.to_integer/1)
      |> List.to_tuple()

    %{width: width, data: data}
  end

  @spec point_to_position(point_t, grid_t) :: integer
  def point_to_position({x, y}, grid), do: grid[:width] * y + x

  @spec position_to_point(integer, grid_t) :: point_t
  def position_to_point(n, grid), do: {rem(n, grid[:width]), div(n, grid[:width])}

  @spec get(grid_t, point_t) :: any
  def get(grid, {x, y}), do: elem(grid[:data], point_to_position({x, y}, grid))

  @spec put(grid_t, point_t, any) :: any
  def put(grid, {x, y}, value),
    do: %{grid | data: put_elem(grid[:data], point_to_position({x, y}, grid), value)}
end
