defmodule Acronym do
  @doc """
  Generate an acronym from a string. 
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t) :: String.t()
  def abbreviate(str) do
    String.replace(str, "-", " ")
    |> remove_punctuation
    |> String.split(" ")
    |> split_mashed_words
    |> take_first_char_of_strings
    |> upcase_strings
    |> Enum.join
  end

  defp take_first_char_of_strings(strings) do
    Enum.map(strings, fn(x) -> String.first(x) end)
  end

  defp upcase_strings(strings) do
    Enum.map(strings, fn(x) -> String.upcase(x) end)
  end

  defp split_mashed_words([]), do: []

  defp split_mashed_words([word|tail]) do
    split_mashed_word(word) ++ split_mashed_words(tail)
  end

  defp split_mashed_word(word) do
    String.graphemes(word)
    |> separate_word_on_capitalized_letter
    |> Enum.join
    |> String.split(" ")
  end

  defp separate_word_on_capitalized_letter(list_of_chars) do
    [first | rest_of_list] = list_of_chars

    Enum.reduce(rest_of_list, [first], fn(x,acc) -> 
     cond do
       String.upcase(x) == x -> acc ++ [" "] ++ [x]
       true -> acc ++ [x]
     end
    end)
  end

  defp remove_punctuation(string) do
    Enum.reduce(punctuation_strings, string, fn(punc, acc) -> 
      String.replace(acc, punc, "")
    end)
  end

  defp punctuation_strings do
    [",", "."]
  end
end
