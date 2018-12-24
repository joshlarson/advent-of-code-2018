defmodule AdventTest do
  use ExUnit.Case

  test "for 1 input, checksum is 1 if there are letters that happen 2 and 3 times" do
    assert Advent.checksum("aabbb\n") == 1
  end

  test "for 1 input, checksum is 0 if there are no letters that happen 3 times" do
    assert Advent.checksum("aabb\n") == 0
  end

  test "for 1 input, checksum is 0 if there are no letters that happen 2 times" do
    assert Advent.checksum("aaabbb\n") == 0
  end

  test "for 2 inputs, checksum is 1 if one string matches 2 and the other matches 3" do
    assert Advent.checksum("aabb\naaabbb\n") == 1
  end

  test "for 2 inputs, checksum is 1 if one string matches both and the other matches nothing" do
    assert Advent.checksum("aabbb\nabbbb\n") == 1
  end

  test "for 2 inputs, checksum is 4 if both strings match both" do
    assert Advent.checksum("aabbb\naaabb\n") == 4
  end
end
