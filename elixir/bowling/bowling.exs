defmodule Bowling do

  @doc """
    Creates a new game of bowling that can be used to store the results of
    the game
  """

  @spec start() :: any
  def start do
    %{frame: 1,
      score: 0,
      first: 0,
      additional_rolls: 0,
      second_shot: false,
      multiplier: 1,
      bonus: false}
  end

  @doc """
    Records the number of pins knocked down on a single roll. Returns `any`
    unless there is something wrong with the given number of pins, in which
    case it returns a helpful message.
  """

  @spec roll(any, integer) :: any | String.t
  def roll(_, roll) when roll < 0, do: {:error, "Pins must have a value from 0 to 10"}
  def roll(_, roll) when roll > 10, do: {:error, "Pins must have a value from 0 to 10"}
  def roll(game, roll) do
    %{first: first} = game

    if(first + roll > 10) do
      {:error, "Pin count exceeds pins on the lane"}
    else
      game
      |> this_frame_score(roll)
      |> previous_closed_frames(roll)
      |> handle_spare(roll)
      |> handle_strikes(roll)
      |> update_frame_number(roll)
    end
  end
  defp this_frame_score(game, roll) do
    %{frame: frame} = game

    cond do
      frame > 10 -> game
      true -> add_score(game, roll, 1)
    end
  end
  defp add_score(game, roll, multiplier) do
    game
    |> Map.update!(:score, fn(score) -> score + roll * multiplier end)
  end
  defp previous_closed_frames(game, roll) do
    %{additional_rolls: additional_rolls, multiplier: multiplier} = game

    cond do
      additional_rolls > 0 -> Map.merge(add_score(game, roll, multiplier), %{additional_rolls: additional_rolls - 1, multiplier: 1})
      true -> game
    end
  end
  defp handle_spare(game, roll) do
    %{second_shot: second_shot, first: first, frame: frame} = game

    cond do
      second_shot && (first + roll == 10) -> Map.merge(game, %{first: 0, additional_rolls: 1, bonus: frame >= 10})
      true -> game
    end
  end
  defp handle_strikes(game, roll) do
    %{additional_rolls: additional_rolls, frame: frame} = game
    multiplier = if additional_rolls > 0 && frame < 11, do: 2, else: 1
    bonus_rolls = if additional_rolls == 0 && frame == 11, do: 0, else: 2
    cond do
      roll == 10 -> Map.merge(game, %{first: 0, additional_rolls: bonus_rolls, multiplier: multiplier, bonus: frame >= 10})
      true -> game
    end
  end
  defp update_frame_number(game, roll) do
    %{frame: frame, second_shot: second_shot} = game
    cond do
      second_shot -> Map.merge(game, %{second_shot: false, first: 0, frame: frame + 1})
      roll == 10 -> Map.merge(game, %{second_shot: false, first: 0, frame: frame + 1})
      true -> Map.merge(game, %{second_shot: true, first: roll})
    end
  end

  @doc """
    Returns the score of a given game of bowling if the game is complete.
    If the game isn't complete, it returns a helpful message.
  """

  @spec score(any) :: integer | String.t
  def score(game) do
    %{frame: frame, additional_rolls: additional_rolls, bonus: bonus, second_shot: second_shot} = game

    cond do
      frame < 11 -> {:error, "Score cannot be taken until the end of the game"}
      frame >= 11 && !bonus && second_shot -> {:error, "Invalid game: too many frames"}
      frame == 11 && additional_rolls > 0 -> {:error, "Score cannot be taken until the end of the game"}
      frame == 12 && additional_rolls > 1 -> {:error, "Score cannot be taken until the end of the game"}
      true -> game[:score]
    end
  end
end
