defmodule Advent do
  def main(args \\ ["input.txt"]) do
    {:ok, content} = args
    |> List.first
    |> File.read

    content
    |> final_frequency
    |> IO.puts
  end
  
  def final_frequency(input) do
    frequency_deltas(input)
    |> Enum.sum
  end

  def frequency_deltas(input) do
    input
    |> String.split("\n")
    |> Enum.map(&parse_directly/1)
  end

  defp parse_directly(str) do
    case Integer.parse(str) do
      {result, _} -> result
      :error -> 0
    end
  end
end
