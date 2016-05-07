defmodule DNA do
  @map %{?G => ?C, ?C => ?G, ?T => ?A, ?A => ?U}  
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> DNA.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    char_list = Enum.map(dna, fn l -> @map[l] end)
  end
end
