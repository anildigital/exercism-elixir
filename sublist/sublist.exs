defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    la = length(a)
    lb = length(b)
    cond do
      is_equal(a,b) -> :equal
      is_sublist(a, b, a, la, lb) -> :sublist
      is_sublist(b, a, b, lb, la) -> :superlist
      is_not_equal(a, b) -> :unequal
    end
  end

  defp is_not_equal(a, b) do
    !is_equal(a,b)
  end

  defp is_equal(a, b) do
    cond do
      a === b -> true
      a !== b -> false
    end
  end

  defp is_sublist(a, b, orig_a, la, lb) when length(a) < length(b) do
    cond do
      (a == []) and (b != []) -> true
      (a == tl(b)) -> true
      hd(a) != hd(b) ->  is_sublist(orig_a, tl(b),  orig_a, la, lb)
      hd(a) === hd(b) -> is_sublist(tl(a), tl(b), orig_a, la, lb)
      hd(a) !== hd(b) -> false
    end
  end

  defp is_sublist(a, b, _orig_a, _la, _lb) when length(a) >= length(b) do
    false
  end
end
