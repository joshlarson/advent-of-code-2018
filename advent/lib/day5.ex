defmodule Day5 do
  def main do
    {:ok, content} = File.read("day5_input.txt")

    content
    |> String.split("\n")
    |> List.first()
    |> reacted()
    |> String.length()
    |> IO.puts()
  end
    
  def reacted(input) do
    input
    |> String.codepoints()
    |> Enum.reduce([], &add_to_reacted/2)
    |> Enum.join()
    |> String.reverse()
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
    a == String.downcase(b) && b == String.upcase(a) ||
      a == String.upcase(b) && b == String.downcase(a)
  end
end
