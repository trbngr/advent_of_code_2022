defmodule Aoc.Year2022.Day04.CampCleanupTest do
  use Aoc.DayCase
  doctest Aoc.Year2022.Day04.CampCleanup, import: true

  alias Aoc.Year2022.Day04.CampCleanup

  describe "part_1/1" do
    test "examples" do
      assert %{reconsider?: false} = CampCleanup.read_pair(["2-4", "6-8"])
      assert %{reconsider?: false} = CampCleanup.read_pair(["2-3", "4-5"])
      assert %{reconsider?: false} = CampCleanup.read_pair(["5-7", "7-9"])
      assert %{reconsider?: true} = CampCleanup.read_pair(["2-8", "3-7"])
    end

    @tag day: 04, year: 2022
    test "input", %{input: input} do
      assert input |> CampCleanup.part_1() == 542
    end
  end

  describe "part_2/1" do
    test "examples" do
      assert %{overlaps?: true} = CampCleanup.read_pair(["5-7", "7-9"])
      assert %{overlaps?: true} = CampCleanup.read_pair(["2-8", "3-7"])
      assert %{overlaps?: true} = CampCleanup.read_pair(["6-6", "4-6"])
      assert %{overlaps?: true} = CampCleanup.read_pair(["2-6", "4-8"])
    end

    @tag day: 04, year: 2022
    test "input", %{input: input} do
      assert input |> CampCleanup.part_2() == 900
    end
  end
end
