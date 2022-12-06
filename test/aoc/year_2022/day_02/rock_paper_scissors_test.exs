defmodule Aoc.Year2022.Day02.RockPaperScissorsTest do
  use Aoc.DayCase
  doctest Aoc.Year2022.Day02.RockPaperScissors, import: true

  alias Aoc.Year2022.Day02.RockPaperScissors

  describe "part_1/1" do
    test "examples" do
      assert "A Y\nB X\nC Z" |> RockPaperScissors.part_1() == 15
    end

    @tag day: 02, year: 2022
    test "input", %{input: input} do
      assert input |> RockPaperScissors.part_1() == 14375
    end
  end

  describe "part_2/1" do
    test "examples" do
      assert "A Y\nB X\nC Z" |> RockPaperScissors.part_2() == 12
    end

    @tag day: 02, year: 2022
    test "input", %{input: input} do
      assert input |> RockPaperScissors.part_2() == 10274
    end
  end
end
