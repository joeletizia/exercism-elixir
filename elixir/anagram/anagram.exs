defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
    Enum.filter(candidates, fn(x) -> 
      hash_and_compare(String.downcase(base), String.downcase(x))
    end)
  end

  defp hash_and_compare(a,a), do: false

  defp hash_and_compare(base, candidate) do
    hash(base) == hash(candidate)
  end

  defp hash(word) do
    String.graphemes(word)
    |> Enum.reduce(%{}, fn(letter, accumulator) ->
      current_value = Map.get(accumulator, letter, 0)
      Map.put(accumulator, letter, current_value + 1)
    end)
  end
end
