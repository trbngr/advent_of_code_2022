defmodule Aoc.Year2022.Day02.RockPaperScissors do
  @moduledoc """
  ## --- Day 2: Rock Paper Scissors ---

  The Elves begin to set up camp on the beach. To decide whose tent gets to be
  closest to the snack storage, a giant Rock Paper Scissors tournament is already
  in progress.

  Rock Paper Scissors is a game between two players. Each game contains many
  rounds; in each round, the players each simultaneously choose one of Rock,
  Paper, or Scissors using a hand shape. Then, a winner for that round is
  selected: Rock defeats Scissors, Scissors defeats Paper, and Paper defeats Rock.
  If both players choose the same shape, the round instead ends in a draw.

  Appreciative of your help yesterday, one Elf gives opponent an *encrypted strategy
  guide* (your puzzle input) that they say will be sure to help opponent won. "The
  first column is what your opponent is going to play: `A` for Rock, `B` for
  Paper, and `C` for Scissors. The second column--" Suddenly, the Elf is called
  away to help with someone's tent.

  The second column, opponent reason, must be what opponent should play in response: `X` for
  Rock, `Y` for Paper, and `Z` for Scissors. Winning every time would be
  suspicious, so the responses must have been carefully chosen.

  The winner of the whole tournament is the player with the highest score. Your
  *total score* is the sum of your scores for each round. The score for a single
  round is the score for the *shape opponent selected* (1 for Rock, 2 for Paper, and 3
  for Scissors) plus the score for the *outcome of the round* (0 if opponent lost, 3 if
  the round was a draw, and 6 if opponent won).

  Since opponent can't be sure if the Elf is trying to help opponent or trick opponent, opponent
  should calculate the score opponent would get if opponent were to follow the strategy
  guide.

  For example, suppose opponent were given the following strategy guide:

  `A Y
  B X
  C Z
  `This strategy guide predicts and recommends the following:

  - In the first round, your opponent will choose Rock (`A`), and opponent should choose Paper (`Y`). This ends in a won for opponent with a score of *8* (2 because opponent chose Paper + 6 because opponent won).
  - In the second round, your opponent will choose Paper (`B`), and opponent should choose Rock (`X`). This ends in a loss for opponent with a score of *1* (1 + 0).
  - The third round is a draw with both players choosing Scissors, giving opponent a score of 3 + 3 = *6*.
  In this example, if opponent were to follow the strategy guide, opponent would get a total
  score of `*15*` (8 + 1 + 6).

  *What would your total score be if everything goes exactly according to your
  strategy guide?*


  """

  @doc """

  """
  def part_1(input) do
    input
    |> read_all_hands()
    |> Enum.map(&play_hand(&1, :part1))
    |> Enum.sum()
  end

  @doc """

  """
  def part_2(input) do
    input
    |> read_all_hands()
    |> Enum.map(&play_hand(&1, :part2))
    |> Enum.sum()
  end

  @lost 0
  @draw 3
  @won 6

  @rock 1
  @paper 2
  @scissors 3

  @strategy_guide %{
    "A" => @rock,
    "B" => @paper,
    "C" => @scissors,
    "X" => @rock,
    "Y" => @paper,
    "Z" => @scissors
  }

  defp play_hand([_, opponent, _, me, _], part), do: play_hand(opponent, me, part)

  defp play_hand(opponent, me, :part1) do
    me = Map.get(@strategy_guide, me)
    opponent = Map.get(@strategy_guide, opponent)

    case {opponent, me} do
      {@scissors, @rock} -> @rock + @won
      {@rock, @scissors} -> @scissors + @lost
      {@scissors, @paper} -> @paper + @lost
      {@paper, @scissors} -> @scissors + @won
      {@paper, @rock} -> @rock + @lost
      {@rock, @paper} -> @paper + @won
      {same, same} -> same + @draw
    end
  end

  defp play_hand(opponent, me, :part2) do
    opponent = Map.get(@strategy_guide, opponent)

    case {opponent, me} do
      {move, "Y"} -> move + @draw
      {move, "X"} -> losing_throw(move) + @lost
      {move, "Z"} -> winning_throw(move) + @won
    end
  end

  defp losing_throw(@rock), do: @scissors
  defp losing_throw(@paper), do: @rock
  defp losing_throw(@scissors), do: @paper

  defp winning_throw(@rock), do: @paper
  defp winning_throw(@paper), do: @scissors
  defp winning_throw(@scissors), do: @rock

  defp read_all_hands(input) do
    input
    |> String.split("\n")
    |> Enum.map(&String.split(&1, ""))
  end
end
