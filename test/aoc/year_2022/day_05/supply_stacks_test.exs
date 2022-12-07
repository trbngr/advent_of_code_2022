defmodule Aoc.Year2022.Day05.SupplyStacksTest do
  use Aoc.DayCase
  doctest Aoc.Year2022.Day05.SupplyStacks, import: true

  alias Aoc.Year2022.Day05.SupplyStacks

  @example_input """
      [D]
  [N] [C]
  [Z] [M] [P]
  1   2   3

  move 1 from 2 to 1
  move 3 from 1 to 3
  move 2 from 2 to 1
  move 1 from 1 to 2
  """

  describe "part_1/1" do
    test "examples" do
      assert %{2 => "D"} = SupplyStacks.parse_stack_row("    [D]")
      assert %{1 => "N", 2 => "C"} = SupplyStacks.parse_stack_row("[N] [C]")
      assert %{1 => "Z", 2 => "M", 3 => "P"} = SupplyStacks.parse_stack_row("[Z] [M] [P]")

      assert %{count: 1, source: 2, destination: 1} =
               SupplyStacks.parse_move("move 1 from 2 to 1")

      assert %{count: 3, source: 1, destination: 3} =
               SupplyStacks.parse_move("move 3 from 1 to 3")

      assert %{count: 2, source: 2, destination: 1} =
               SupplyStacks.parse_move("move 2 from 2 to 1")

      assert %{count: 1, source: 1, destination: 2} =
               SupplyStacks.parse_move("move 1 from 1 to 2")

      assert %{
               moves: [
                 %{count: 1, destination: 1, source: 2},
                 %{count: 3, destination: 3, source: 1},
                 %{count: 2, destination: 1, source: 2},
                 %{count: 1, destination: 2, source: 1}
               ],
               stacks: %{1 => ["N", "Z"], 2 => ["D", "C", "M"], 3 => ["P"]}
             } = SupplyStacks.read_environment(@example_input)

      assert %{1 => ["D", "N", "Z"], 2 => ["C", "M"], 3 => ["P"]} =
               SupplyStacks.execute_move(:part1, %{count: 1, source: 2, destination: 1}, %{
                 1 => ["N", "Z"],
                 2 => ["D", "C", "M"],
                 3 => ["P"]
               })

      assert "CMZ" = SupplyStacks.part_1(@example_input)
    end

    @tag day: 05, year: 2022
    test "input", %{input: input} do
      assert input |> SupplyStacks.part_1() == "PSNRGBTFT"
    end
  end

  describe "part_2/1" do
    test "examples" do
      assert %{1 => [], 2 => ["C", "M"], 3 => ["D", "N", "Z", "P"]} =
               SupplyStacks.execute_move(:part2, %{count: 3, source: 1, destination: 3}, %{
                 1 => ["D", "N", "Z"],
                 2 => ["C", "M"],
                 3 => ["P"]
               })

      assert %{1 => ["C", "M"], 2 => [], 3 => ["D", "N", "Z", "P"]} =
               SupplyStacks.execute_move(:part2, %{count: 2, source: 2, destination: 1}, %{
                 1 => [],
                 2 => ["C", "M"],
                 3 => ["D", "N", "Z", "P"]
               })

      assert %{1 => ["M"], 2 => ["C"], 3 => ["D", "N", "Z", "P"]} =
               SupplyStacks.execute_move(:part2, %{count: 1, source: 1, destination: 2}, %{
                 1 => ["C", "M"],
                 2 => [],
                 3 => ["D", "N", "Z", "P"]
               })

      assert "MCD" = SupplyStacks.part_2(@example_input)
    end

    @tag day: 05, year: 2022
    test "input", %{input: input} do
      assert input |> SupplyStacks.part_2() == "BNTZFPMMW"
    end
  end
end
