defmodule Aoc.Year2022.Day06.TuningTroubleTest do
  use Aoc.DayCase
  doctest Aoc.Year2022.Day06.TuningTrouble, import: true

  alias Aoc.Year2022.Day06.TuningTrouble

  describe "part_1/1" do
    test "examples" do
      assert 7 == TuningTrouble.start_of_packet("mjqjpqmgbljsphdztnvjfqwrcgsmlb", 4)
      assert 5 == TuningTrouble.start_of_packet("bvwbjplbgvbhsrlpgdmjqwftvncz", 4)
      assert 6 == TuningTrouble.start_of_packet("nppdvjthqldpwncqszvftbrmjlhg", 4)
      assert 10 == TuningTrouble.start_of_packet("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", 4)
      assert 11 == TuningTrouble.start_of_packet("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", 4)
    end

    @tag day: 06, year: 2022
    test "input", %{input: input} do
      assert input |> TuningTrouble.part_1() == 1848
    end
  end

  describe "part_2/1" do
    test "examples" do
      assert 19 == TuningTrouble.start_of_packet("mjqjpqmgbljsphdztnvjfqwrcgsmlb", 14)
      assert 23 == TuningTrouble.start_of_packet("bvwbjplbgvbhsrlpgdmjqwftvncz", 14)
      assert 23 == TuningTrouble.start_of_packet("nppdvjthqldpwncqszvftbrmjlhg", 14)
      assert 29 == TuningTrouble.start_of_packet("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", 14)
      assert 26 == TuningTrouble.start_of_packet("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", 14)
    end

    @tag day: 06, year: 2022
    test "input", %{input: input} do
      assert input |> TuningTrouble.part_2() == 2308
    end
  end
end
