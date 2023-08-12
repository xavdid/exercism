defmodule RobotSimulator do
  @type robot() :: {direction(), position()}
  @type direction() :: :north | :east | :south | :west
  @type position() :: {integer(), integer()}

  @offsets %{north: {0, 1}, east: {1, 0}, south: {0, -1}, west: {-1, 0}}
  @directions [:north, :east, :south, :west]

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction, position) :: robot() | {:error, String.t()}
  def create(direction \\ :north, position \\ {0, 0})

  # valid case
  def create(direction, {x, y})
      when direction in [:north, :east, :south, :west] and is_integer(x) and
             is_integer(y) do
    {direction, {x, y}}
  end

  # invalid direction
  def create(direction, _position) when direction not in [:north, :east, :south, :west] do
    {:error, "invalid direction"}
  end

  # the only other case, invalid position
  def create(_direction, _position) do
    {:error, "invalid position"}
  end

  @spec add_tuples({integer(), integer()}, {integer(), integer()}) :: {integer(), integer()}
  defp add_tuples({a1, a2}, {b1, b2}) do
    {a1 + b1, a2 + b2}
  end

  @spec rotate(direction(), :left | :right) :: any
  defp rotate(start, dir) do
    operation =
      case dir do
        :left -> &Kernel.-/2
        :right -> &Kernel.+/2
      end

    next_index =
      Enum.find_index(@directions, &(&1 == start))
      |> operation.(1)
      |> rem(4)

    Enum.at(@directions, next_index)
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot, instructions :: String.t()) :: robot() | {:error, String.t()}
  def simulate(robot, instructions) do
    {ins, rest} = String.split_at(instructions, 1)
    {direction, position} = robot

    case ins do
      "A" ->
        simulate({direction, add_tuples(position, @offsets[direction])}, rest)

      "L" ->
        simulate({rotate(direction, :left), position}, rest)

      "R" ->
        simulate({rotate(direction, :right), position}, rest)

      # no more instrunctions
      "" ->
        robot

      _ ->
        {:error, "invalid instruction"}
    end
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot) :: direction()
  def direction(robot) do
    elem(robot, 0)
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot) :: position()
  def position(robot) do
    elem(robot, 1)
  end
end
