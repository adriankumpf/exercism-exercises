defmodule Gigasecond do
  @doc """
  Calculate a date one billion seconds after an input date.
  """

  @gigasecond round(1.0e9)

  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) :: :calendar.datetime

  def from(date) do
    date
    |> :calendar.datetime_to_gregorian_seconds
    |> Kernel.+(@gigasecond)
    |> :calendar.gregorian_seconds_to_datetime
  end

end
