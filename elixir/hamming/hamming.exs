defmodule DNA do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> DNA.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: non_neg_integer
  def hamming_distance(a, a, matches \\ 0), do: {:ok, matches}
  def hamming_distance(l1,l2, _) when length(l1) != length(l2), do: { :error, "Lists must be the same length." }

  def hamming_distance([h|left_tail], [h|right_tail], matches) do
    hamming_distance(left_tail, right_tail, matches)
  end

  def hamming_distance([_|left_tail], [_|right_tail], matches) do
    hamming_distance(left_tail, right_tail, matches + 1)
  end
end
