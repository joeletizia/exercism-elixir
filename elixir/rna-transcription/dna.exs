defmodule DNA do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> DNA.to_rna('ACTG')
  'UGAC'
  """
  @transcription_map %{?A => ?U, ?C => ?G, ?T => ?A, ?G => ?C}
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    Enum.map(dna, &(Map.get(@transcription_map, &1)))
  end
end
