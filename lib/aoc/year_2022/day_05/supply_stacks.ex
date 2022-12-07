defmodule Aoc.Year2022.Day05.SupplyStacks do
  @moduledoc """
  ## --- Day 5: Supply Stacks ---

  The expedition can depart as soon as the final supplies have been unloaded from
  the ships. Supplies are stored in stacks of marked *crates*, but because the
  needed supplies are buried under many other crates, the crates need to be
  rearranged.

  The ship has a *giant cargo crane* capable of moving crates between stacks. To
  ensure none of the crates get crushed or fall over, the crane operator will
  rearrange them in a series of carefully-planned steps. After the crates are
  rearranged, the desired crates will be at the top of each stack.

  The Elves don't want to interrupt the crane operator during this delicate
  procedure, but they forgot to ask her *which* crate will end up where, and they
  want to be ready to unload them as soon as possible so they can embark.

  They do, however, have a drawing of the starting stacks of crates *and* the
  rearrangement procedure (your puzzle input). For example:

  `    [D]
  [N] [C]
  [Z] [M] [P]
   1   2   3

  move 1 from 2 to 1
  move 3 from 1 to 3
  move 2 from 2 to 1
  move 1 from 1 to 2
  `In this example, there are three stacks of crates. Stack 1 contains two crates:
  crate `Z` is on the bottom, and crate `N` is on top. Stack 2 contains three
  crates; from bottom to top, they are crates `M`, `C`, and `D`. Finally, stack 3
  contains a single crate, `P`.

  Then, the rearrangement procedure is given. In each step of the procedure, a
  quantity of crates is moved from one stack to a different stack. In the first
  step of the above rearrangement procedure, one crate is moved from stack 2 to
  stack 1, resulting in this configuration:

  `[D]
  [N] [C]
  [Z] [M] [P]
   1   2   3
  `In the second step, three crates are moved from stack 1 to stack 3. Crates are
  moved *one at a time*, so the first crate to be moved (`D`) ends up below the
  second and third crates:

  `        [Z]
          [N]
      [C] [D]
      [M] [P]
   1   2   3
  `Then, both crates are moved from stack 2 to stack 1. Again, because crates are
  moved *one at a time*, crate `C` ends up below crate `M`:

  `        [Z]
          [N]
  [M]     [D]
  [C]     [P]
   1   2   3
  `Finally, one crate is moved from stack 1 to stack 2:

  `        [*Z*]
          [N]
          [D]
  [*C*] [*M*] [P]
   1   2   3
  `The Elves just need to know *which crate will end up on top of each stack*; in
  this example, the top crates are `C` in stack 1, `M` in stack 2, and `Z` in
  stack 3, so you should combine these together and give the Elves the message
  `*CMZ*`.

  *After the rearrangement procedure completes, what crate ends up on top of each
  stack?*


  """

  @doc """

  """
  def part_1(input) do
    %{stacks: stacks, moves: moves} = read_environment(input)

    moves
    |> Enum.reduce(stacks, &execute_move(:part1, &1, &2))
    |> Enum.map(fn {_index, [top | _]} -> top end)
    |> Enum.join()
  end

  @doc """

  """
  def part_2(input) do
    %{stacks: stacks, moves: moves} = read_environment(input)

    moves
    |> Enum.reduce(stacks, &execute_move(:part2, &1, &2))
    |> Enum.map(fn {_index, [top | _]} -> top end)
    |> Enum.join()
  end

  def execute_move(:part1, %{count: count, source: source, destination: destination}, stacks) do
    source_stack = Map.get(stacks, source)
    destination_stack = Map.get(stacks, destination)

    {source_stack, destination_stack} =
      source_stack
      |> Enum.with_index()
      |> Enum.reduce_while({source_stack, destination_stack}, fn {_, index},
                                                                 {source, destination} ->
        cond do
          index < count ->
            {crate, source} = List.pop_at(source, 0)
            {:cont, {source, [crate | destination]}}

          true ->
            {:halt, {source, destination}}
        end
      end)

    stacks
    |> Map.put(source, source_stack)
    |> Map.put(destination, destination_stack)
  end

  def execute_move(:part2, %{count: count, source: source, destination: destination}, stacks) do
    source_stack = Map.get(stacks, source)
    destination_stack = Map.get(stacks, destination)

    {source_stack, pulled_crates} =
      source_stack
      |> Enum.with_index()
      |> Enum.reduce_while({source_stack, []}, fn {_, index}, {source, crates} ->
        cond do
          index < count ->
            {crate, source} = List.pop_at(source, 0)
            {:cont, {source, [crate | crates]}}

          true ->
            {:halt, {source, crates}}
        end
      end)

    stacks
    |> Map.put(source, source_stack)
    |> Map.put(destination, Enum.reverse(pulled_crates) ++ destination_stack)
  end

  def read_environment(input) do
    %{stacks: stacks, moves: moves} =
      input
      |> String.split("\n")
      |> Enum.with_index(1)
      |> Enum.reduce(%{stacks: %{}, moves: []}, &read_input_line/2)

    %{
      moves: Enum.reverse(moves),
      stacks: Enum.into(stacks, %{}, fn {index, crates} -> {index, Enum.reverse(crates)} end)
    }
  end

  defp read_input_line({"move" <> rest, _index}, %{moves: moves} = acc) do
    move = parse_move("move" <> rest)
    %{acc | moves: [move | moves]}
  end

  defp read_input_line({line, _index}, %{stacks: stacks} = acc) do
    cond do
      String.contains?(line, "[") ->
        stacks =
          line
          |> parse_stack_row()
          |> Enum.reduce(stacks, fn {index, crate}, acc ->
            acc
            |> Map.update(index, [crate], fn existing -> [crate | existing] end)
          end)

        %{acc | stacks: stacks}

      true ->
        acc
    end
  end

  def parse_stack_row(line) when is_binary(line) do
    line
    |> String.graphemes()
    |> Enum.chunk_every(4)
    |> Enum.with_index(1)
    |> Enum.reduce(%{}, fn
      {["[", x, "]" | _], index}, acc -> Map.put(acc, index, x)
      {_, _index}, acc -> acc
    end)
  end

  @move_regex ~r/(\d+) from (\d+) to (\d+)/
  def parse_move("move " <> instructions) do
    [_, count, source, destination] = Regex.run(@move_regex, instructions)

    %{
      count: String.to_integer(count),
      source: String.to_integer(source),
      destination: String.to_integer(destination)
    }
  end
end
