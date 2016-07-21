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
  @error_number "0000000000"
  @spec number(String.t) :: String.t
  def number(raw) do
    result = {:ok, raw}
              |> check_for_letters
              |> remove_special_characters
              |> check_for_length_and_us_country_code

    case result do
      {:ok, number}  -> number
      {:error, data} -> @error_number 
    end
  end

  defp remove_special_characters({:error, data}), do: {:error, data}
  defp remove_special_characters({:ok, number}) do
    result = number
              |> String.replace("-", "")
              |> String.replace("(", "")
              |> String.replace(")", "")
              |> String.replace(" ", "")
              |> String.replace(".", "")

    {:ok, result}
  end

  defp check_for_letters({:error, data}), do: {:error, data}
  defp check_for_letters({:ok, number}) do
    cond do
      String.match?(number, ~r/[a-zA-Z]/) -> {:error, "String contains letters"}
      true -> {:ok, number} 
    end
  end


  defp check_for_length_and_us_country_code({:error, d}), do: {:error, d}
  defp check_for_length_and_us_country_code({:ok, number}) do
    cond do
      String.length(number) == 11 -> remove_us_country_code(number)
      String.length(number) == 9 -> {:error, "The length is wrong"}
      true -> {:ok, number}
    end
  end

  defp remove_us_country_code(phone_number) do
    cond do
       String.first(phone_number) == "1" -> {:ok, String.slice(phone_number, 1..-1)}
       true                              -> {:error, "The length is wrong"}
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
    number(raw)
    |> String.slice(0..2)
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
    unformatted_number = number(raw)

    "(#{area_code(unformatted_number)}) #{seven_digit_number(unformatted_number)}"
  end

  defp seven_digit_number(number) do
    "#{String.slice(number, 3..5)}-#{String.slice(number, 6..9)}"
  end
end
