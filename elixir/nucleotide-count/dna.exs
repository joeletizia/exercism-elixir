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
  def count(_, nucleotide, n \\ 0) when not nucleotide in @nucleotides, do: raise ArgumentError
  def count('', _, n), do: n
  def count([h|_], _, _) when not h in @nucleotides, do: raise ArgumentError
  def count([h|tl], h, n), do: count(tl, h, n + 1)
  def count([h|tl], t, n), do: count(tl, t, n)

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> DNA.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @base_histogram %{?A => 0, ?T => 0, ?C => 0, ?G => 0}
  @spec histogram([char]) :: map
  def histogram([], hist \\ @base_histogram), do: hist
  def histogram([h|_], _) when not h in @nucleotides, do: raise ArgumentError
  def histogram([h|tl], hist) do
      current_value = Map.get(hist, h, 0)
      updated_histogram = Map.put(hist, h, current_value + 1)
      histogram(tl, updated_histogram)
  end
end
