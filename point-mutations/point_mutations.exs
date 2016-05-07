defmodule DNA do
  def hamming(strand1, strand2) do
    mapf = fn t ->
      cond do
        elem(t, 0) != elem(t, 1) -> 1
        true -> 0
      end
    end
    
    Enum.zip(strand1, strand2)
    |> Enum.map(mapf)
    |> Enum.reduce(&(&1+&2))
  end
  
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> DNA.hamming_distance('AAGTCATA', 'TAGCGATC')
  4
  """
  @spec hamming_distance([char], [char]) :: non_neg_integer
  def hamming_distance(strand1, strand2) do
    cond do
      (strand1 === strand2) -> 0
      (length(strand1)) != (length(strand2)) -> nil
      true -> hamming(strand1, strand2)
    end
  end
end
