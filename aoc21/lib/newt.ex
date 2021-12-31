defmodule Newt do
  @type point_t :: %{x: integer, y: integer}

  @type velocity_t :: %{vx: integer, vy: integer}

  @spec slow_velocity(velocity_t()) :: velocity_t()
  def slow_velocity(v) do
    vx =
      if v.vx < 0,
        do: v.vx + 1,
        else: max(0, v.vx - 1)

    %{vx: vx, vy: v.vy - 1}
  end

  @spec apply_velocity(point_t(), velocity_t()) :: point_t()
  def apply_velocity(p, v), do: %{x: p.x + v.vx, y: p.y + v.vy}
end
