defmodule Day2 do
  def main do
    {:ok, content} = File.read("day2_input.txt")

    content
    |> checksum
    |> IO.puts

    content
    |> common_letters
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

  def common_letters(input) do
    box_ids = String.split(input, "\n")
              |> Enum.map(&String.codepoints/1)

    {id1, id2} = box_ids
                 |> Enum.map(fn id -> {id, find_with_one_mismatch(id, box_ids)} end)
                 |> Enum.filter(fn {_, other_ids} -> other_ids |> Enum.any? end)
                 |> Enum.map(fn {id, other_ids} -> {id, List.first(other_ids)} end)
                 |> List.first

    Enum.zip(id1, id2)
    |> Enum.filter(fn {x, y} -> x == y end)
    |> Enum.map(fn {x, _} -> x end)
    |> Enum.join
  end

  defp find_with_one_mismatch(id1, box_ids) do
    box_ids
    |> Enum.filter(fn other_id -> count_mismatches(id1, other_id) == 1 end)
  end

  def count_mismatches(id1, id2) do
    Enum.zip(id1, id2)
    |> Enum.count(fn {x, y} -> x != y end)
  end
end
