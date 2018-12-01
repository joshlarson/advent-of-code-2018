defmodule AdventTest do
  use ExUnit.Case

  test "can read a single frequency" do
    assert Advent.final_frequency("+1") == 1
    assert Advent.final_frequency("-2") == -2
  end

  test "can combine multiple frequencies" do
    assert Advent.final_frequency("+1\n-2") == -1
  end

  test "works with a trailing newline" do
    assert Advent.final_frequency("+1\n-2\n") == -1
  end

  test "can parse a single frequency into a list" do
    assert Advent.frequency_deltas("+1") == [1]    
    assert Advent.frequency_deltas("-2") == [-2]    
  end

  test "can parse multiple frequencies into a list" do
    assert Advent.frequency_deltas("+1\n-2") == [1, -2]
  end
end
