defmodule Aoc.Year2022.Day07.NoSpaceLeftOnDeviceTest do
  use Aoc.DayCase
  doctest Aoc.Year2022.Day07.NoSpaceLeftOnDevice, import: true

  alias Aoc.Year2022.Day07.NoSpaceLeftOnDevice

  @example_input """
  $ cd /
  $ ls
  dir a
  14848514 b.txt
  8504156 c.dat
  dir d
  $ cd a
  $ ls
  dir e
  29116 f
  2557 g
  62596 h.lst
  $ cd e
  $ ls
  584 i
  $ cd ..
  $ cd ..
  $ cd d
  $ ls
  4060174 j
  8033020 d.log
  5626152 d.ext
  7214296 k
  """

  @example_fs %{
    "a" => %{
      "e" => %{
        "i" => 584
      },
      "f" => 29116,
      "g" => 2557,
      "h.lst" => 62596
    },
    "b.txt" => 14_848_514,
    "c.dat" => 8_504_156,
    "d" => %{
      "d.ext" => 5_626_152,
      "d.log" => 8_033_020,
      "j" => 4_060_174,
      "k" => 7_214_296
    }
  }

  describe "part_1/1" do
    test "examples" do
      assert @example_fs = NoSpaceLeftOnDevice.parse_filesystem(@example_input)

      assert 584 + 29116 + 2557 + 62596 ==
               NoSpaceLeftOnDevice.dir_size(%{
                 "a" => %{
                   "e" => %{
                     "i" => 584
                   },
                   "f" => 29116,
                   "g" => 2557,
                   "h.lst" => 62596
                 }
               })

      assert [{"d", 24_933_642}, {"e", 584}, {"a", 94853}, {"/", 48_381_165}] =
               NoSpaceLeftOnDevice.dir_sizes({"/", @example_fs})

      assert 95437 = NoSpaceLeftOnDevice.part_1(@example_input)
    end

    @tag day: 07, year: 2022
    test "input", %{input: input} do
      assert input |> NoSpaceLeftOnDevice.part_1() == 1_423_358
    end
  end

  describe "part_2/1" do
    test "examples" do
      assert 24_933_642 = NoSpaceLeftOnDevice.part_2(@example_input)
    end

    @tag day: 07, year: 2022
    test "input", %{input: input} do
      assert input |> NoSpaceLeftOnDevice.part_2() == 545_729
    end
  end
end
