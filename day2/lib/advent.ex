defmodule Advent do
  def main(args \\ ["input.txt"]) do
    {:ok, content} = args
                      |> List.first
                      |> File.read

    content
    |> checksum
    |> IO.puts
  end

  def checksum(input) do
    box_ids = String.split(input, "\n")
    count_of_exactly_n_of_something(box_ids, 3) * count_of_exactly_n_of_something(box_ids, 2)
  end

  defp count_of_exactly_n_of_something(box_ids, n) do
    box_ids
    |> Enum.count(fn s -> has_exactly_n_of_something(s, n) end)
  end

  defp has_exactly_n_of_something(box_id, n) do
    box_id
    |> String.codepoints
    |> Enum.group_by(&(&1))
    |> Enum.any?(fn {_, value} -> Enum.count(value) == n end)
  end
end
