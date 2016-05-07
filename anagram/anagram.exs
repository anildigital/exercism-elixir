defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
    Enum.filter(candidates, &(is_anagram?(&1, base) and not_same?(&1, base)))
  end

  defp is_anagram?(word, base) do
    count_of_letters(word) == count_of_letters(base)   
  end

  defp not_same?(word, base) do
    String.downcase(word) != String.downcase(base)
  end

  defp count_of_letters(word) do
    String.codepoints(word)
    |>
    Enum.reduce(%{}, fn(letter, map) ->
      Map.update map, String.downcase(letter), 1, &(&1 + 1)
    end)
  end
end
