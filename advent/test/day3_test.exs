defmodule Day3Test do
  use ExUnit.Case

  describe "overlaps" do
    test "finds the overlap when one piece is the full board" do
      assert Day3.overlaps("#1 @ 0,0: 4x4\n#2 @ 0,0: 100x100\n") == 16
      assert Day3.overlaps("#1 @ 0,0: 2x2\n#2 @ 0,0: 100x100\n") == 4
    end

    test "finds the overlap when both pieces are anchored in the corner" do
      assert Day3.overlaps("#1 @ 0,0: 40x2\n#2 @ 0,0: 3x10\n") == 6
    end

    test "finds the overlap when one piece is not anchored in the corner" do
      assert Day3.overlaps("#1 @ 0,0: 2x2\n#2 @ 1,1: 2x2\n") == 1
    end
  end

  describe "parse_claim" do
    test "finds the x_size" do
      assert Day3.parse_claim("#1 @ 1,3: 4x5")[:x_size] == 4
    end

    test "finds the y_size" do
      assert Day3.parse_claim("#1 @ 1,3: 4x5")[:y_size] == 5
    end

    test "finds the x_start" do
      assert Day3.parse_claim("#1 @ 1,3: 4x5")[:x_start] == 1
    end

    test "finds the y_start" do
      assert Day3.parse_claim("#1 @ 1,3: 4x5")[:y_start] == 3
    end
  end
end
