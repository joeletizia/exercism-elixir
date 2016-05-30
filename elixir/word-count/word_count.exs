defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    sentence
    |> trim_special_chars
    |> split_sentence
    |> remove_empty_strings
    |> downcase_all_words
    |> build_map
  end

  @spec trim_special_chars(String.t) :: String.t
  defp trim_special_chars(sentence) do
    Enum.reduce(special_characters, sentence, fn(char, acc) -> 
     String.replace(acc, char, "")
    end)
  end

  @spec downcase_all_words([String.t]) :: [String.t]
  defp downcase_all_words(words) do
    Enum.map(words, fn(word) -> String.downcase(word) end)
  end

  @spec remove_empty_strings([String.t]) :: [String.t]
  defp remove_empty_strings([]) do
    []
  end
  defp remove_empty_strings([""|tail]) do
    remove_empty_strings(tail)
  end
  defp remove_empty_strings([head|tail]) do
    [head] ++ remove_empty_strings(tail)
  end


  @spec split_sentence(String.t) :: [String.t]
  defp split_sentence(sentence) do
    String.replace(sentence, "_", " ")
    |> String.split(" ")
  end

  @spec build_map([String.t]) :: map
  defp build_map(list_of_strings) do
    Enum.reduce(list_of_strings, %{}, fn(x, acc) -> increment_map(x, acc) end)
  end

  @spec increment_map(String.t, map) :: map
  defp increment_map(key, map) do
    value = Map.get(map, key, 0)
    Map.put(map, key, value + 1)
  end

  defp special_characters do
    [",", "!", ":", "&", ".", "@", "^", "%", "$"]
  end
end
