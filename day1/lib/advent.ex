defmodule Advent do
  def main(args \\ ["input.txt"]) do
    {:ok, content} = args
    |> List.first
    |> File.read

    content
    |> final_frequency
    |> IO.puts

    content
    |> first_aggregate_duplicate
    |> IO.puts
  end

  def first_aggregate_duplicate(input) do
    aggregate_frequencies(input)
    |> first_duplicate
  end

  def aggregate_frequencies(input) do
    frequency_deltas(input)
    |> Stream.cycle
    |> Stream.scan(&+/2)
  end

  def first_duplicate(list) do
    list
    |> Enum.reduce_while(MapSet.new([0]), &check_for_duplicate/2)
  end

  defp check_for_duplicate(x, set) do
    if x in set do
      {:halt, x}
    else
      {:cont, set |> MapSet.put(x) }
    end
  end

  def final_frequency(input) do
    frequency_deltas(input)
    |> Enum.sum
  end

  def frequency_deltas(input) do
    input
    |> String.split("\n")
    |> Enum.map(&parse_directly/1)
    |> Enum.filter(&(&1 != 0))
  end

  defp parse_directly(str) do
    case Integer.parse(str) do
      {result, _} -> result
      :error -> 0
    end
  end
end
