defmodule Year do
  @doc """
  Returns whether 'year' is a leap year.

  A leap year occurs:

  on every year that is evenly divisible by 4
  except every year that is evenly divisible by 100
  except every year that is evenly divisible by 400.
  """
  @spec leap_year?(non_neg_integer) :: boolean
  def leap_year?(year) do
    divisible_by_4 = fn year -> rem(year, 4) == 0 end 
    divisible_by_100 = fn year -> rem(year, 100) == 0 end 
    divisible_by_400 = fn year -> rem(year, 400) == 0 end

    case {divisible_by_400.(year), divisible_by_100.(year), divisible_by_4.(year)} do
      {true, _, _} -> true
      {false, true, _} -> false
      {false, false, true} -> true
      _ -> false       
    end
  end
end
