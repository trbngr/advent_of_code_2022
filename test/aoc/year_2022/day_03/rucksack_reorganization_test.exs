defmodule Aoc.Year2022.Day03.RucksackReorganizationTest do
  use Aoc.DayCase
  doctest Aoc.Year2022.Day03.RucksackReorganization, import: true

  alias Aoc.Year2022.Day03.RucksackReorganization

  describe "part_1/1" do
    test "examples" do
      assert %{common: "p", priority: 16} =
               RucksackReorganization.parse_rucksack("vJrwpWtwJgWrhcsFMMfFFhFp")

      assert %{common: "L", priority: 38} =
               RucksackReorganization.parse_rucksack("jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL")

      assert %{common: "P", priority: 42} =
               RucksackReorganization.parse_rucksack("PmmdzqPrVvPwwTWBwg")

      assert 157 =
               RucksackReorganization.part_1(~s"""
               vJrwpWtwJgWrhcsFMMfFFhFp
               jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
               PmmdzqPrVvPwwTWBwg
               wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
               ttgJtRGJQctTZtZT
               CrZsJsPPZsGzwwsLwLmpwMDw
               """)
    end

    @tag day: 03, year: 2022
    test "input", %{input: input} do
      assert input |> RucksackReorganization.part_1() == 7691
    end
  end

  describe "part_2/1" do
    test "examples" do
      assert %{common: "r", priority: 18} =
               RucksackReorganization.parse_groups([
                 "vJrwpWtwJgWrhcsFMMfFFhFp",
                 "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL",
                 "PmmdzqPrVvPwwTWBwg"
               ])

      assert %{common: "Z", priority: 52} =
               RucksackReorganization.parse_groups([
                 "wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn",
                 "ttgJtRGJQctTZtZT",
                 "CrZsJsPPZsGzwwsLwLmpwMDw"
               ])
    end

    @tag day: 03, year: 2022
    test "input", %{input: input} do
      assert input |> RucksackReorganization.part_2() == 2508
    end
  end
end
