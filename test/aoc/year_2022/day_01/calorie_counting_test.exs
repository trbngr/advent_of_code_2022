defmodule Aoc.Year2022.Day01.CalorieCountingTest do
  use Aoc.DayCase
  doctest Aoc.Year2022.Day01.CalorieCounting, import: true

  alias Aoc.Year2022.Day01.CalorieCounting

  describe "part_1/1" do
    test "examples" do
    end

    @tag day: 01, year: 2022
    test "input", %{input: input} do
      assert input |> CalorieCounting.part_1() == 71300
    end
  end

  describe "part_2/1" do
    test "examples" do
    end

    @tag day: 01, year: 2022
    test "input", %{input: input} do
      assert input |> CalorieCounting.part_2() == 209_691
    end
  end
end
