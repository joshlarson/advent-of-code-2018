defmodule Day6 do
  def main() do
    input =
      File.read("day6_input.txt")
      |> elem(1)
      |> String.split("\n")
      |> Enum.filter(&(&1 != ""))

    input
    |> largest_safe_area()
    |> IO.puts()
  end

  def largest_safe_area(input) do
    grid = grid(input)

    grid.closest_neighbors
    |> Enum.filter(fn
      {_, {:error}} -> false
      {_, {:ok, _}} -> true
    end)
    |> Enum.map(fn {_, {:ok, neighbor}} -> neighbor end)
    |> Enum.filter(fn neighbor -> !MapSet.member?(grid.infinite_area_indices, neighbor) end)
    |> Enum.group_by(& &1)
    |> Enum.map(fn {_, arr} -> Enum.count(arr) end)
    |> Enum.max()
  end

  def grid(input) do
    points = Enum.map(input, &parse_point/1)

    boundary = boundary(points)

    %{x_min: x_min, y_min: y_min, x_max: x_max, y_max: y_max} = boundary

    points_in_grid =
      x_min..x_max
      |> Enum.flat_map(fn x -> y_min..y_max |> Enum.map(fn y -> {x, y} end) end)

    closest_neighbors =
      points_in_grid
      |> Map.new(fn pt -> {pt, closest_neighbor(points, pt)} end)

    boundary_points =
      Enum.concat(
        y_min..y_max |> Enum.flat_map(fn y -> [{x_min, y}, {x_max, y}] end),
        x_min..x_max |> Enum.flat_map(fn x -> [{x, y_min}, {x, y_max}] end)
      )

    infinite_area_indices =
      boundary_points
      |> Enum.map(fn pt -> closest_neighbors[pt] end)
      |> Enum.filter(fn
        {:error} -> false
        {:ok, _} -> true
      end)
      |> MapSet.new(fn {:ok, ind} -> ind end)

    %{
      closest_neighbors: closest_neighbors,
      infinite_area_indices: infinite_area_indices
    }
  end

  def parse_point(point_str) do
    [x, y] = point_str |> String.split(", ") |> Enum.map(&String.to_integer/1)
    {x, y}
  end

  defp closest_neighbor(points, point) do
    min_distance_and_indexes =
      points
      |> Enum.map(fn point_on_grid -> distance(point_on_grid, point) end)
      |> Enum.with_index()
      |> Enum.group_by(fn {distance, _index} -> distance end)
      |> Enum.min_by(fn {distance, _distance_index_list} -> distance end)

    case min_distance_and_indexes do
      {dist, [{dist, index}]} -> {:ok, index}
      {dist, [{dist, _index} | _]} -> {:error}
    end
  end

  def boundary(points) do
    {x_min, x_max} =
      points
      |> Enum.map(fn {x, _} -> x end)
      |> Enum.min_max()

    {y_min, y_max} =
      points
      |> Enum.map(fn {_, y} -> y end)
      |> Enum.min_max()

    %{
      x_min: x_min,
      x_max: x_max,
      y_min: y_min,
      y_max: y_max
    }
  end

  def distance({x1, y1}, {x2, y2}) do
    abs(y1 - y2) + abs(x1 - x2)
  end
end
