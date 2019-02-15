defmodule Day3 do
  def main do
    {:ok, content} = File.read("day3_input.txt")

    content
    |> overlaps
    |> IO.puts

    content
    |> non_overlapping_claim
    |> IO.puts
  end

  def overlaps(input) do
    input
    |> parse_all_claims
    |> overlapping_points
    |> Enum.count
  end

  def non_overlapping_claim(input) do
    claims = parse_all_claims(input)
    overlapping_points = overlapping_points(claims)

    claim = claims
    |> Enum.find(fn claim -> !has_overlap?(claim, overlapping_points) end)

    claim[:claim_number]
  end

  defp has_overlap?(claim, overlapping_points) do
    claim
    |> point_list
    |> Enum.any?(fn pt -> overlapping_points |> MapSet.member?(pt) end)
  end

  defp parse_all_claims(input) do
    input
    |> String.split("\n")
    |> Enum.filter( fn s -> s != "" end )
    |> Enum.map(&parse_claim/1)
  end

  defp overlapping_points(claims) do
    claims
    |> Enum.flat_map(&point_list/1)
    |> Enum.group_by(&(&1))
    |> Map.new(fn {pt, pts} -> {pt, Enum.count(pts)} end)
    |> Enum.filter(fn {_, count} -> count > 1 end)
    |> MapSet.new(fn {pt, _} -> pt end)
  end

  def parse_claim(claim) do
    [claim_number, _, start, size] = String.split(claim)

    {x_size, y_size} = parse_size(size)
    {x_start, y_start} = parse_start(start)

    %{
      claim_number: claim_number |> String.slice(1..-1) |> String.to_integer,
      x_size: x_size,
      y_size: y_size,
      x_start: x_start,
      y_start: y_start,
    }
  end

  defp parse_size(size) do
    [x_size, y_size] = size
    |> String.split("x")
    |> Enum.map(&String.to_integer/1)

    {x_size, y_size}
  end

  defp parse_start(start) do
    [x_start, y_start] = start
    |> String.slice(0..-2)
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)

    {x_start, y_start}
  end

  defp point_list(claim) do
    claim[:x_start]..(claim[:x_start] + claim[:x_size] - 1)
    |> Enum.flat_map( fn x ->
      claim[:y_start]..(claim[:y_start] + claim[:y_size] - 1)
      |> Enum.map( fn y ->
	{x,  y}
      end )
    end )
  end
end
