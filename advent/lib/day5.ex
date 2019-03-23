defmodule Day5 do
  def main do
    input =
      File.read("day5_input.txt")
      |> elem(1)
      |> String.split("\n")
      |> List.first()
      |> to_charlist()

    input
    |> reacted()
    |> Enum.count()
    |> IO.puts()

    input
    |> remove_and_react()
    |> Enum.count()
    |> IO.puts()
  end

  def reacted(input) do
    input
    |> Enum.reduce('', &add_to_reacted/2)
    |> Enum.reverse()
  end

  def remove_and_react(input) do
    ?a..?z
    |> Enum.map(&remove_and_react(input, &1))
    |> Enum.min_by(&Enum.count/1)
  end

  defp remove_and_react(input, char) do
    input
    |> Enum.filter(&(&1 != char && !react?(&1, char)))
    |> reacted()
  end

  def add_to_reacted(new_char, reacted = [head | tail]) do
    if react?(head, new_char) do
      tail
    else
      [new_char | reacted]
    end
  end

  def add_to_reacted(new_char, []) do
    [new_char]
  end

  def react?(a, b) do
    a + ?A == b + ?a || a + ?a == b + ?A
  end
end
