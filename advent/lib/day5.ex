defmodule Day5 do
  def main do
    {:ok, content} = File.read("day5_input.txt")

    content
    |> String.split("\n")
    |> List.first()
    |> to_charlist()
    |> reacted()
    |> Enum.count()
    |> IO.puts()
  end

  def reacted(input) do
    input
    |> Enum.reduce('', &add_to_reacted/2)
    |> Enum.reverse()
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
