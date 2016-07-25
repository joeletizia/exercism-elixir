defmodule ETL do
  @doc """
  Transform an index into an inverted index.

  ## Examples

  iex> ETL.transform(%{"a" => ["ABILITY", "AARDVARK"], "b" => ["BALLAST", "BEAUTY"]})
  %{"ability" => "a", "aardvark" => "a", "ballast" => "b", "beauty" =>"b"}
  """
  @spec transform(map) :: map
  def transform(input) do
    tuples = Enum.map(input, &(&1))

    Enum.reduce(tuples, %{}, fn({key, words}, acc) ->
      Enum.reduce(words, acc, &put_into_map(&2, &1, key))
    end)
  end

  defp put_into_map(map, word, original_key) do
    Map.put(map, String.downcase(word), original_key)
  end
end
