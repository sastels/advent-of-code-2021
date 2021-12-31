defmodule Day17 do
  @type target_t :: %{x_min: integer, x_max: integer, y_min: integer, y_max: integer}

  @spec in_target?(Newt.point_t(), target_t()) :: boolean
  def in_target?(p, target) when p.x < target.x_min, do: false
  def in_target?(p, target) when p.x > target.x_max, do: false
  def in_target?(p, target) when p.y < target.y_min, do: false
  def in_target?(p, target) when p.y > target.y_max, do: false
  def in_target?(_p, _target), do: true

  def too_far(p, target) when p.x > target.x_max, do: true
  def too_far(p, target) when p.y < target.y_min, do: true
  def too_far(_p, _target), do: false

  def good_velocity?(p, v, target) do
    cond do
      too_far(p, target) -> false
      in_target?(p, target) -> true
      true -> good_velocity?(Newt.apply_velocity(p, v), Newt.slow_velocity(v), target)
    end
  end

  def part_2(target) do
    Range.new(0, target.x_max + 1)
    |> Enum.reduce(0, fn vx, num_good ->
      num_good +
        (Range.new(target.y_min, -target.y_min)
         |> Enum.filter(&good_velocity?(%{x: 0, y: 0}, %{vx: vx, vy: &1}, target))
         |> Enum.count())
    end)
  end

  def main do
    target = %{x_min: 135, x_max: 155, y_min: -102, y_max: -78}
    IO.inspect(target |> part_2(), label: "part 2")
  end
end
