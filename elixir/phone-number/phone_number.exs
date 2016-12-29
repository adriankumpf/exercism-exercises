defmodule Phone do
  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("123-456-7890")
  "1234567890"

  iex> Phone.number("+1 (303) 555-1212")
  "3035551212"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @spec number(String.t) :: String.t
  def number(raw) do
    raw |> clean |> validate |> to_string
  end

  defp clean(raw) do
    raw
    |> String.downcase
    |> to_charlist
    |> Enum.filter(&alphanumeric?/1)
  end

  defp alphanumeric?(char), do: char in (Enum.to_list(?0..?9) ++ Enum.to_list(?a..?z))

  defp validate(number), do: number |> check_length |> check_numeric

  defp check_length(n) when length(n) == 10, do: n
  defp check_length([?1|tail]) when length(tail) == 10, do: tail
  defp check_length(_), do: '0000000000'

  defp check_numeric(number) do
    if number |> Enum.all?(fn c -> c in ?0..?9 end) do
      number
    else
      '0000000000'
    end
  end

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("123-456-7890")
  "123"

  iex> Phone.area_code("+1 (303) 555-1212")
  "303"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t) :: String.t
  def area_code(raw) do
    raw |> number |> String.slice(0,3)
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("123-456-7890")
  "(123) 456-7890"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t) :: String.t
  def pretty(raw) do
    number = raw |> number
    area_code =  raw |> area_code
    subscriber_1 = number |> String.slice(3,3)
    subscriber_2 = number |> String.slice(6,4)

    "(#{area_code}) #{subscriber_1}-#{subscriber_2}"
  end
end
