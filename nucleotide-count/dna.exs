defmodule DNA do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> DNA.count('AATAA', ?A)
  4

  iex> DNA.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) do
    if !(Enum.member?(@nucleotides, nucleotide)) do
      raise ArgumentError
    end
    r = Enum.reduce(strand, %{}, fn(nucleotide, map) ->
      cond do
        !(Enum.member?(@nucleotides, nucleotide)) -> raise ArgumentError
        true -> Map.update map, nucleotide, 1, &(&1 + 1)
      end
    end)
    Map.get(r, nucleotide, 0)
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> DNA.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: Dict.t
  def histogram(strand) do
    Enum.reduce(@nucleotides, %{},  fn(nucleotide, map) ->
      Map.update map, nucleotide, count(strand, nucleotide), &(&1)
    end )
  end
end
