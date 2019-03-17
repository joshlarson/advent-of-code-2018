defmodule Day4Test do
  use ExUnit.Case

  describe "sleepiest" do
    test "works if there is one guard" do
      guard =
        Day4.sleepiest([
          "[1518-11-01 00:00] Guard #10 begins shift",
          "[1518-11-01 00:05] falls asleep",
          "[1518-11-01 00:25] wakes up"
        ])

      assert guard[:id] == 10

      guard =
        Day4.sleepiest([
          "[1518-11-01 00:00] Guard #4 begins shift",
          "[1518-11-01 00:05] falls asleep",
          "[1518-11-01 00:25] wakes up"
        ])

      assert guard[:id] == 4
    end

    test "picks out the guard whose sleep time is longer" do
      guard =
        Day4.sleepiest([
          "[1518-11-01 00:00] Guard #10 begins shift",
          "[1518-11-01 00:05] falls asleep",
          "[1518-11-01 00:25] wakes up",
          "[1518-11-02 00:00] Guard #4 begins shift",
          "[1518-11-02 00:04] falls asleep",
          "[1518-11-02 00:25] wakes up"
        ])

      assert guard[:id] == 4
    end

    test "works even if minutes are spread across shifts" do
      guard =
        Day4.sleepiest([
          "[1518-11-01 00:00] Guard #10 begins shift",
          "[1518-11-01 00:05] falls asleep",
          "[1518-11-01 00:25] wakes up",
          "[1518-11-02 00:00] Guard #4 begins shift",
          "[1518-11-02 00:04] falls asleep",
          "[1518-11-02 00:25] wakes up",
          "[1518-11-03 00:00] Guard #10 begins shift",
          "[1518-11-03 00:42] falls asleep",
          "[1518-11-03 00:44] wakes up"
        ])

      assert guard[:id] == 10
    end

    test "also finds the guard's sleepiest minute" do
      guard =
        Day4.sleepiest([
          "[1518-11-01 00:00] Guard #10 begins shift",
          "[1518-11-01 00:05] falls asleep",
          "[1518-11-01 00:26] wakes up",
          "[1518-11-02 00:00] Guard #4 begins shift",
          "[1518-11-02 00:04] falls asleep",
          "[1518-11-02 00:25] wakes up",
          "[1518-11-03 00:00] Guard #10 begins shift",
          "[1518-11-03 00:25] falls asleep",
          "[1518-11-03 00:44] wakes up"
        ])

      assert guard[:minute] == 25
    end

    test "works even when the input is jumbled" do
      guard =
        Day4.sleepiest([
          "[1518-11-03 00:25] falls asleep",
          "[1518-11-02 00:04] falls asleep",
          "[1518-11-03 00:00] Guard #10 begins shift",
          "[1518-11-02 00:00] Guard #4 begins shift",
          "[1518-11-02 00:25] wakes up",
          "[1518-11-01 00:00] Guard #10 begins shift",
          "[1518-11-03 00:44] wakes up",
          "[1518-11-01 00:26] wakes up",
          "[1518-11-01 00:05] falls asleep"
        ])

      assert guard[:minute] == 25
      assert guard[:id] == 10
    end
  end

  describe "sleepy_minute" do
    test "finds a guard's sleepiest minute" do
      guard =
        Day4.sleepy_minute([
          "[1518-11-01 00:00] Guard #10 begins shift",
          "[1518-11-01 00:05] falls asleep",
          "[1518-11-01 00:06] wakes up"
        ])

      assert guard[:minute] == 5
      assert guard[:id] == 10
    end

    test "sorts the guards by most-asleep minute rather than most asleep minutes" do
      guard =
        Day4.sleepy_minute([
          "[1518-11-01 00:00] Guard #10 begins shift",
          "[1518-11-01 00:05] falls asleep",
          "[1518-11-01 00:07] wakes up",
          "[1518-11-02 00:00] Guard #4 begins shift",
          "[1518-11-02 00:05] falls asleep",
          "[1518-11-02 00:30] wakes up",
          "[1518-11-03 00:00] Guard #10 begins shift",
          "[1518-11-03 00:06] falls asleep",
          "[1518-11-03 00:08] wakes up"
        ])

      assert guard[:minute] == 6
      assert guard[:id] == 10
    end

    test "sorts by number of times the minute was asleep, not where in the alphabet it is" do
      guard =
        Day4.sleepy_minute([
          "[1518-11-01 00:00] Guard #10 begins shift",
          "[1518-11-01 00:05] falls asleep",
          "[1518-11-01 00:07] wakes up",
          "[1518-11-02 00:00] Guard #4 begins shift",
          "[1518-11-02 00:45] falls asleep",
          "[1518-11-02 00:59] wakes up",
          "[1518-11-03 00:00] Guard #10 begins shift",
          "[1518-11-03 00:06] falls asleep",
          "[1518-11-03 00:08] wakes up"
        ])

      assert guard[:minute] == 6
      assert guard[:id] == 10
    end

    test "works even if a guard does not sleep" do
      guard =
        Day4.sleepy_minute([
          "[1518-11-01 00:00] Guard #10 begins shift",
          "[1518-11-01 00:05] falls asleep",
          "[1518-11-01 00:07] wakes up",
          "[1518-11-02 00:00] Guard #4 begins shift",
          "[1518-11-03 00:00] Guard #10 begins shift",
          "[1518-11-03 00:06] falls asleep",
          "[1518-11-03 00:08] wakes up"
        ])

      assert guard[:minute] == 6
      assert guard[:id] == 10
    end

    test "works even if the input is jumbled" do
      guard =
        Day4.sleepy_minute([
          "[1518-11-01 00:05] falls asleep",
          "[1518-11-03 00:06] falls asleep",
          "[1518-11-01 00:00] Guard #10 begins shift",
          "[1518-11-02 00:00] Guard #4 begins shift",
          "[1518-11-01 00:07] wakes up",
          "[1518-11-03 00:00] Guard #10 begins shift",
          "[1518-11-03 00:08] wakes up"
        ])

      assert guard[:minute] == 6
      assert guard[:id] == 10
    end
  end

  describe "roster" do
    test "marks when guards take their shifts" do
      roster =
        Day4.roster([
          "[1518-11-01 00:00] Guard #4 begins shift",
          "[1518-11-02 00:00] Guard #10 begins shift",
          "[1518-11-03 00:00] Guard #4 begins shift"
        ])

      assert roster |> shifts_for_guard(4) |> shift_count() == 2

      assert roster |> shifts_for_guard(4) |> shift_number(0) |> at_minute(0) |> asleep?() ==
               false

      assert roster |> shifts_for_guard(4) |> shift_number(1) |> at_minute(0) |> asleep?() ==
               false

      assert roster |> shifts_for_guard(10) |> shift_count() == 1

      assert roster |> shifts_for_guard(10) |> shift_number(0) |> at_minute(0) |> asleep?() ==
               false
    end

    test "marks when guards fall asleep" do
      roster =
        Day4.roster([
          "[1518-11-01 00:00] Guard #10 begins shift",
          "[1518-11-01 00:05] falls asleep",
          "[1518-11-01 00:08] wakes up"
        ])

      assert roster |> shifts_for_guard(10) |> shift_count() == 1

      assert roster |> shifts_for_guard(10) |> shift_number(0) |> at_minute(0) |> asleep?() ==
               false

      assert roster |> shifts_for_guard(10) |> shift_number(0) |> at_minute(5) |> asleep?() ==
               true

      assert roster |> shifts_for_guard(10) |> shift_number(0) |> at_minute(8) |> asleep?() ==
               false
    end

    defp shifts_for_guard(roster, guard_id) do
      roster |> Map.get(guard_id)
    end

    defp shift_count(nil) do
      0
    end

    defp shift_count(shift_list) do
      shift_list |> Enum.count()
    end

    defp shift_number(shift_list, index) do
      shift_list |> Enum.at(index)
    end

    defp at_minute(shift, minute) do
      shift |> MapSet.member?(minute)
    end

    defp asleep?(minute) do
      minute
    end
  end
end
