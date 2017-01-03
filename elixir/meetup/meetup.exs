defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
  :monday | :tuesday | :wednesday
  | :thursday | :friday | :saturday | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @days %{monday: 1, tuesday: 2, wednesday: 3, thursday: 4, friday: 5, saturday: 6, sunday: 7}

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date
  def meetup(y, m, wday, :first),  do: valid_days(y, m, wday, days_of_month(y, m)) |> Enum.at(0)
  def meetup(y, m, wday, :second), do: valid_days(y, m, wday, days_of_month(y, m)) |> Enum.at(1)
  def meetup(y, m, wday, :third),  do: valid_days(y, m, wday, days_of_month(y, m)) |> Enum.at(2)
  def meetup(y, m, wday, :fourth), do: valid_days(y, m, wday, days_of_month(y, m)) |> Enum.at(3)
  def meetup(y, m, wday, :last),   do: valid_days(y, m, wday, days_of_month(y, m)) |> Enum.at(-1)
  def meetup(y, m, wday, :teenth), do: valid_days(y, m, wday, 13..19) |> Enum.at(0)

  defp days_of_month(y, m), do: 1..:calendar.last_day_of_the_month(y, m)

  defp valid_days(year, month, weekday, range) do
    range
    |> Enum.map(&({ year, month, &1 }))
    |> Enum.filter(fn date -> :calendar.day_of_the_week(date) == @days[weekday] end)
  end

end
