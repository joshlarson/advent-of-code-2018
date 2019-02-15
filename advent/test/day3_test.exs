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

  describe "non_overlapping_claim" do
    test "identifies the non-overlapping claim if it is the first one" do
      assert Day3.non_overlapping_claim("#1 @ 5,5: 2x2\n#2 @ 1,3: 4x4\n#3 @ 3,1: 4x4\n") == 1
    end

    test "identifies the non-overlapping claim if it is not the first one" do
      assert Day3.non_overlapping_claim("#1 @ 1,3: 4x4\n#2 @ 3,1: 4x4\n#3 @ 5,5: 2x2\n") == 3
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

    test "finds the claim number" do
      assert Day3.parse_claim("#17 @ 1,3: 4x5")[:claim_number] == 17
    end
  end
end
