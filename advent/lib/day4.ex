defmodule Day4 do
  def main do
    {:ok, content} = File.read("day4_input.txt")

    %{id: guard_id, minute: minute} =
      content
      |> String.split("\n")
      |> Enum.filter(fn s -> s != "" end)
      |> sleepiest

    IO.puts(guard_id * minute)
  end

  def sleepiest(input) do
    roster =
      input
      |> Enum.sort()
      |> roster()

    {guard_id, _} =
      roster
      |> Enum.map(fn {id, shifts} -> {id, total_minutes_asleep(shifts)} end)
      |> Enum.max_by(fn {_, count} -> count end)

    {minute, _} =
      roster[guard_id]
      |> Enum.reduce(&Enum.concat/2)
      |> Enum.group_by(& &1)
      |> Enum.max_by(fn {_, instances_for_minute} -> Enum.count(instances_for_minute) end)

    %{
      id: guard_id,
      minute: minute
    }
  end

  defp total_minutes_asleep(shifts) do
    shifts
    |> Enum.map(&Enum.count/1)
    |> Enum.sum()
  end

  def roster(input) do
    input
    |> Enum.map(fn line -> parse_line(line) end)
    |> Enum.reduce(new_roster_builder(), fn command, roster -> command.(roster) end)
    |> final_roster()
  end

  defp parse_line(line) do
    line |> String.split() |> parse_args
  end

  defp parse_args([_, _, "Guard", guard_id, "begins", "shift"]) do
    guard_id = guard_id |> String.slice(1..-1) |> String.to_integer()

    fn r -> start_shift(r, guard_id) end
  end

  defp parse_args([_, time, "falls", "asleep"]) do
    minute = time |> String.slice(3..4) |> String.to_integer()
    fn r -> fall_asleep(r, minute) end
  end

  defp parse_args([_, time, "wakes", "up"]) do
    minute = time |> String.slice(3..4) |> String.to_integer()
    fn r -> wake_up(r, minute) end
  end

  defp new_roster_builder() do
    %{
      :roster => %{},
      :current_guard => nil,
      :minutes_asleep_so_far => [],
      :asleep_since => nil
    }
  end

  defp start_shift(roster_builder, guard_id) do
    %{store_current_shift(roster_builder) | :current_guard => guard_id}
  end

  defp fall_asleep(roster_builder, minute) do
    %{roster_builder | :asleep_since => minute}
  end

  defp wake_up(
         roster_builder = %{
           :asleep_since => asleep_since,
           :minutes_asleep_so_far => minutes_asleep_so_far
         },
         minute
       ) do
    new_minutes_asleep_so_far = minutes_asleep_so_far |> Enum.concat(asleep_since..(minute - 1))
    %{roster_builder | :asleep_since => nil, :minutes_asleep_so_far => new_minutes_asleep_so_far}
  end

  defp store_current_shift(roster_builder = %{:current_guard => nil}) do
    roster_builder
  end

  defp store_current_shift(
         roster_builder = %{
           :current_guard => guard_id,
           :minutes_asleep_so_far => minutes_asleep_so_far
         }
       ) do
    existing_shifts = roster_builder.roster |> Map.get(guard_id, [])

    new_shifts = Enum.concat(existing_shifts, [MapSet.new(minutes_asleep_so_far)])

    new_roster =
      roster_builder.roster
      |> Map.merge(%{guard_id => new_shifts})

    %{roster_builder | :roster => new_roster, :current_guard => nil, :minutes_asleep_so_far => []}
  end

  defp final_roster(roster_builder) do
    store_current_shift(roster_builder).roster
  end
end
