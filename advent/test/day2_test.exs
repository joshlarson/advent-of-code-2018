defmodule Day2Test do
  use ExUnit.Case

  describe "checksum" do
    test "for 1 input, checksum is 1 if there are letters that happen 2 and 3 times" do
      assert Day2.checksum("aabbb\n") == 1
    end

    test "for 1 input, checksum is 0 if there are no letters that happen 3 times" do
      assert Day2.checksum("aabb\n") == 0
    end

    test "for 1 input, checksum is 0 if there are no letters that happen 2 times" do
      assert Day2.checksum("aaabbb\n") == 0
    end

    test "for 2 inputs, checksum is 1 if one string matches 2 and the other matches 3" do
      assert Day2.checksum("aabb\naaabbb\n") == 1
    end

    test "for 2 inputs, checksum is 1 if one string matches both and the other matches nothing" do
      assert Day2.checksum("aabbb\nabbbb\n") == 1
    end

    test "for 2 inputs, checksum is 4 if both strings match both" do
      assert Day2.checksum("aabbb\naaabb\n") == 4
    end
  end

  describe "common_letters" do
    test "finds the common letters if there are two strings" do
      assert Day2.common_letters("a\nb\n") == ""
      assert Day2.common_letters("ac\nab\n") == "a"
      assert Day2.common_letters("ca\nba\n") == "a"
      assert Day2.common_letters("ecb\nebb\n") == "eb"
    end

    test "finds the commons letters between the right pair of strings" do
      assert Day2.common_letters("abc\nabb\nxyz\n") == "ab"
      assert Day2.common_letters("abc\nxyz\nabb\n") == "ab"
      assert Day2.common_letters("xyz\nabc\nabb\n") == "ab"
    end
  end

  describe "count_mismatches" do
    test "finds the number of common letters between two strings" do
      assert Day2.count_mismatches([], []) == 0
      assert Day2.count_mismatches(["a"], ["a"]) == 0
      assert Day2.count_mismatches(["a"], ["b"]) == 1
      assert Day2.count_mismatches(["a", "b", "c", "d"], ["a", "a", "a", "a"]) == 3
    end
  end
end
