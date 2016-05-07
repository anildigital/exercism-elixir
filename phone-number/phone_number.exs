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
    invalid =  "0000000000"
    cond do
      contains_invalid_chars?(raw) -> cleanup_invalid_chars(raw)
      is_length_11_chars?(raw) and starts_with_1?(raw) -> cleanup_starting_1(raw)
      is_length_11_chars?(raw) or  is_length_9_chars?(raw)  -> invalid
      contains_no_digits?(raw) -> invalid
      is_length_10_chars?(raw)-> raw
    end
  end

  def cleanup_invalid_chars(raw) do
    String.replace(raw, ~r/[^\d]/, "")
  end

  def cleanup_starting_1(raw) do
    String.replace(raw, ~r/^1/, "")
  end

  defp is_length_11_chars?(raw) do
    (String.length(raw) == 11)    
  end

  defp is_length_9_chars?(raw) do
    (String.length(raw) == 9)    
  end

  defp is_length_10_chars?(raw) do
    (String.length(raw) == 10)   
  end

  defp contains_invalid_chars?(raw) do
    Regex.match?(~r/[\(|\.|\)]/, raw)
  end

  defp starts_with_1?(raw) do
    Regex.match?(~r/^1/, raw)    
  end

  def contains_no_digits?(raw) do
    Regex.match?(~r/[^\d]/, raw)    
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
    cond do
      is_length_10_chars?(raw) -> _get_area_code(raw)
      is_length_11_chars?(raw) -> _get_area_code2(raw)     
    end
  end

  def _get_area_code(raw) do
    Regex.named_captures(~r/(?<area_code>\d{3})./, raw)["area_code"]    
  end

  def _get_area_code2(raw) do
    Regex.named_captures(~r/1(?<area_code>\d{3})./, raw)["area_code"]    
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
    _number = number(raw)
    area_code = area_code(_number)
    number = String.replace(_number, area_code, "")
    exchange = Regex.named_captures(~r/(?<first_three>\d{3})./, number)["first_three"]
    subscriber = String.replace(number, exchange, "")
    "(#{area_code}) #{exchange}-#{subscriber}"
  end
end
