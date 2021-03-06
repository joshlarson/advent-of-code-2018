defmodule Day1Test do
  use ExUnit.Case

  test "can read a single frequency" do
    assert Day1.final_frequency("+1") == 1
    assert Day1.final_frequency("-2") == -2
  end

  test "can combine multiple frequencies" do
    assert Day1.final_frequency("+1\n-2") == -1
  end

  test "works with a trailing newline" do
    assert Day1.final_frequency("+1\n-2\n") == -1
  end

  test "can parse a single frequency into a list" do
    assert Day1.frequency_deltas("+1") == [1]
    assert Day1.frequency_deltas("-2") == [-2]
  end

  test "can parse multiple frequencies into a list" do
    assert Day1.frequency_deltas("+1\n-2\n") == [1, -2]
  end

  test "can find the first aggregate duplicate" do
    assert Day1.first_aggregate_duplicate("+1\n-2\n+3\n+1\n") == 2
    assert Day1.first_aggregate_duplicate("+1\n-1\n") == 0
    assert Day1.first_aggregate_duplicate("+3\n+3\n+4\n-2\n-4\n") == 10
    assert Day1.first_aggregate_duplicate("-6\n+3\n+8\n+5\n-6\n") == 5
    assert Day1.first_aggregate_duplicate("+7\n+7\n-2\n-7\n-4\n") == 14
  end

  test "can create aggregate frequency stream" do
    assert Day1.aggregate_frequencies("+1\n-2\n+2\n") |> Enum.take(3) == [1, -1, 1]
  end

  test "aggregate stream cycles back to the beginning" do
    assert Day1.aggregate_frequencies("+1\n-2\n") |> Enum.take(4) == [1, -1, 0, -2]
    assert Day1.aggregate_frequencies("+1\n-2\n+2\n") |> Enum.take(7) == [1, -1, 1, 2, 0, 2, 3]

    assert Day1.aggregate_frequencies("+1\n-2\n+3\n+1") |> Enum.take(6) == [1, -1, 2, 3, 4, 2]
  end

  test "can find the first duplicate" do
    assert Day1.first_duplicate([1, 1]) == 1
    assert Day1.first_duplicate([3, 1, 1]) == 1
  end

  test "an implicit 0 is already assumed" do
    assert Day1.first_duplicate([3, 0, 1]) == 0
  end
end
