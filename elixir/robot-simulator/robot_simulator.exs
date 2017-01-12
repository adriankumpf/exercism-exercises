defmodule RobotSimulator do
  alias __MODULE__, as: RS

  @enforce_keys [:pos, :dir]
  defstruct [:pos, :dir]

  @directions [:north, :east, :south, :west]

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: { integer, integer }) :: any
  def create(d \\ :north, p \\ {0, 0})
  def create(d, _)
    when not d in @directions,
    do: { :error, "invalid direction" }
  def create(d, p = {x, y})
    when is_integer(x) and is_integer(y),
    do: %RS{pos: p, dir: d}
  def create(_, _),
    do: { :error, "invalid position" }

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t ) :: any
  def simulate(robot, ""), do: robot
  def simulate(%RS{pos: p, dir: d}, "L" <> ins) do
    simulate(%RS{pos: p, dir: turn(d, -1)}, ins)
  end
  def simulate(%RS{pos: p, dir: d}, "R" <> ins) do
    simulate(%RS{pos: p, dir: turn(d, +1)}, ins)
  end
  def simulate(%RS{pos: p, dir: d}, "A" <> ins) do
    simulate(%RS{pos: advance(d, p), dir: d}, ins)
  end
  def simulate(_, _), do: { :error, "invalid instruction" }

  defp turn(cur_dir, n) do
      cur_index = Enum.find_index(@directions, &(&1 == cur_dir))
      new_index = rem(cur_index + n, length(@directions))
      Enum.at(@directions, new_index)
  end

  defp advance(:north, {x, y}), do: {x, y + 1}
  defp advance(:south, {x, y}), do: {x, y - 1}
  defp advance(:east,  {x, y}), do: {x + 1, y}
  defp advance(:west,  {x, y}), do: {x - 1, y}

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot), do: robot.dir

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: { integer, integer }
  def position(robot), do: robot.pos

end
