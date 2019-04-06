defmodule Day6Test do
  use ExUnit.Case

  describe "largest_safe_area" do
    test "works when one point is in the center of a small plus sign" do
      assert ["5, 1", "4, 1", "6, 1", "5, 0", "5, 2"] |> Day6.largest_safe_area() == 1
    end

    test "works when one point is in the center of a larger plus sign" do
      assert ["8, 5", "2, 5", "5, 5", "5, 2", "5, 8"] |> Day6.largest_safe_area() == 9
    end

    test "works when there is more than one finite area" do
      assert ["8, 5", "2, 5", "5, 5", "5, 2", "5, 8", "3, 4", "3, 5", "3, 6"]
             |> Day6.largest_safe_area() == 6
    end

    test "works on the sample input" do
      assert ["1, 1", "1, 6", "8, 3", "3, 4", "5, 5", "8, 9"] |> Day6.largest_safe_area() == 17
    end
  end

  describe "infinite_area?" do
    test "returns true if an index would have an infinite area" do
      assert ["5, 1", "4, 1", "6, 1", "5, 0", "5, 2"]
             |> Day6.grid()
             |> Map.get(:infinite_area_indices)
             |> MapSet.member?(0) == false

      assert ["5, 1", "4, 1", "6, 1", "5, 0", "5, 2"]
             |> Day6.grid()
             |> Map.get(:infinite_area_indices)
             |> MapSet.member?(1) == true

      assert ["5, 1", "4, 1", "6, 1", "5, 0", "5, 2"]
             |> Day6.grid()
             |> Map.get(:infinite_area_indices)
             |> MapSet.member?(2) == true

      assert ["5, 1", "4, 1", "6, 1", "5, 0", "5, 2"]
             |> Day6.grid()
             |> Map.get(:infinite_area_indices)
             |> MapSet.member?(3) == true

      assert ["5, 1", "4, 1", "6, 1", "5, 0", "5, 2"]
             |> Day6.grid()
             |> Map.get(:infinite_area_indices)
             |> MapSet.member?(4) == true

      assert ["8, 5", "2, 5", "5, 5", "5, 2", "5, 8"]
             |> Day6.grid()
             |> Map.get(:infinite_area_indices)
             |> MapSet.member?(0) == true

      assert ["8, 5", "2, 5", "5, 5", "5, 2", "5, 8"]
             |> Day6.grid()
             |> Map.get(:infinite_area_indices)
             |> MapSet.member?(1) == true

      assert ["8, 5", "2, 5", "5, 5", "5, 2", "5, 8"]
             |> Day6.grid()
             |> Map.get(:infinite_area_indices)
             |> MapSet.member?(2) == false

      assert ["8, 5", "2, 5", "5, 5", "5, 2", "5, 8"]
             |> Day6.grid()
             |> Map.get(:infinite_area_indices)
             |> MapSet.member?(3) == true

      assert ["8, 5", "2, 5", "5, 5", "5, 2", "5, 8"]
             |> Day6.grid()
             |> Map.get(:infinite_area_indices)
             |> MapSet.member?(4) == true

      assert ["4, 4"] |> Day6.grid() |> Map.get(:infinite_area_indices) |> MapSet.member?(0) ==
               true
    end
  end

  describe "parse_point" do
    test "works" do
      assert Day6.parse_point("0, 0") == {0, 0}
      assert Day6.parse_point("0, 7") == {0, 7}
      assert Day6.parse_point("4, 7") == {4, 7}
    end
  end

  describe "distance" do
    test "works" do
      assert Day6.distance({0, 4}, {0, 2}) == 2
      assert Day6.distance({0, 2}, {0, 4}) == 2
      assert Day6.distance({5, 2}, {2, 4}) == 5
      assert Day6.distance({2, 2}, {5, 4}) == 5
    end
  end

  describe "closest_neighbor" do
    test "finds a close neighbor" do
      assert ["0, 0", "5, 3"] |> Day6.grid() |> Map.get(:closest_neighbors) |> Map.get({1, 1}) ==
               {:ok, 0}

      assert ["0, 0", "5, 3"] |> Day6.grid() |> Map.get(:closest_neighbors) |> Map.get({5, 2}) ==
               {:ok, 1}
    end

    test "returns :error if there are multiple equidistant neighbors" do
      assert ["0, 0", "5, 3"] |> Day6.grid() |> Map.get(:closest_neighbors) |> Map.get({1, 3}) ==
               {:error}
    end
  end

  describe "boundary" do
    test "finds the boundary of the grid" do
      assert ["2, 1", "5, 3"] |> Enum.map(&Day6.parse_point/1) |> Day6.boundary() == %{
               x_min: 2,
               x_max: 5,
               y_min: 1,
               y_max: 3
             }

      assert ["5, 1", "2, 3"] |> Enum.map(&Day6.parse_point/1) |> Day6.boundary() == %{
               x_min: 2,
               x_max: 5,
               y_min: 1,
               y_max: 3
             }

      assert ["5, 3", "2, 1"] |> Enum.map(&Day6.parse_point/1) |> Day6.boundary() == %{
               x_min: 2,
               x_max: 5,
               y_min: 1,
               y_max: 3
             }
    end
  end
end
