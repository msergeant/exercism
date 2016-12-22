defmodule RobotSimulator do
  @directions [:north, :east, :south, :west]
  @invalid_instruction {:error, "invalid instruction"}

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: { integer, integer }) :: any
  def create(direction,_) when not(direction in @directions) do {:error, "invalid direction"} end
  def create(_,position) when not(is_tuple(position) and tuple_size(position) == 2) do {:error, "invalid position"} end
  def create(_,{x,y}) when not(is_number(x) and is_number(y)) do {:error, "invalid position"} end
  def create(direction \\ :north, position \\ {0,0}) do
    %{direction: direction, position: position}
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t ) :: any
  def simulate(robot, instructions) do
    instructions
    |> String.to_char_list
    |> Enum.reduce(robot, fn(movement, acc) ->
      do_move(acc, movement)
    end)
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot) do
    Map.fetch!(robot, :direction)
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: { integer, integer }
  def position(robot) do
    Map.fetch!(robot, :position)
  end

  defp do_move(robot, movement) when movement == ?R do turn_right(robot) end
  defp do_move(robot, movement) when movement == ?L do turn_left(robot) end
  defp do_move(robot, movement) when movement == ?A do advance(robot) end
  defp do_move(_, _) do @invalid_instruction end

  defp advance(%{direction: facing, position: {x,y} }) when facing == :north do %{ direction: facing, position: {x, y + 1}} end
  defp advance(%{direction: facing, position: {x,y} }) when facing == :east do %{ direction: facing, position: {x + 1, y}} end
  defp advance(%{direction: facing, position: {x,y} }) when facing == :west do %{ direction: facing, position: {x - 1, y}} end
  defp advance(%{direction: facing, position: {x,y} }) when facing == :south do %{ direction: facing, position: {x, y - 1}} end
  defp advance(_) do @invalid_instruction end

  defp turn_right(%{direction: facing, position: position}) do
    current_pos_index = Enum.find_index(@directions, &(&1 == facing))
    new_direction = Enum.fetch!(@directions, rem(current_pos_index + 1, 4))

    %{direction: new_direction, position: position}
  end
  defp turn_right(_) do @invalid_instruction end

  defp turn_left(%{direction: facing, position: position}) do
    current_pos_index = Enum.find_index(@directions, &(&1 == facing))
    new_direction = Enum.fetch!(@directions, rem(current_pos_index + 3, 4))

    %{direction: new_direction, position: position}
  end
  defp turn_left(_) do @invalid_instruction end

end
