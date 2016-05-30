defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "HORSE" => "1H1O1R1S1E"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "1H1O1R1S1E" => "HORSE"
  """
  require IEx

  @spec encode(String.t) :: String.t
  def encode(""), do: ""
  def encode(string) do
    String.graphemes(string)
    |> calculate_runs
    |> Enum.reverse
    |> decompose_for_encoding
  end

  @spec decode(String.t) :: String.t
  def decode(string) do
    decompose_string_into_tuples(string)
    |> build_string_from_tuple_list
  end

  defp calculate_runs(list_of_strings) do
    Enum.reduce(list_of_strings, [], fn(x, acc) -> push_run_tuple(x, acc) end)
  end

  defp push_run_tuple(character, [{character, current_count} | tail]) do
    [{character, current_count + 1}] ++ tail
  end

  defp push_run_tuple(character, [h|t]) do
    [{character, 1}] ++ [h|t]
  end

  defp push_run_tuple(character, []) do
    [{character, 1}]
  end


  defp decompose_for_encoding(_, str \\ "")
  defp decompose_for_encoding([{character, count}|tail], str) do
    new_string = str <> "#{count}#{character}"
    decompose_for_encoding(tail, new_string)
  end

  defp decompose_for_encoding([], str) do
    str
  end

  defp decompose_string_into_tuples(string) do
    parse_string_into_lists_of_count_and_letter_combos(string)
    |> build_tuples_from_lists_of_letter_count_combos
  end

  defp parse_string_into_lists_of_count_and_letter_combos(string) do
    Regex.scan(~r/(\d+)(.)/, string)
  end

  defp build_tuples_from_lists_of_letter_count_combos(list_of_lists) do
    Enum.map(list_of_lists, fn(x) -> 
     count = parse_integer(Enum.at(x, 1))
     {Enum.at(x, 2), count}
    end)
  end

  defp build_string_from_tuple_list(_, str \\ "")
  defp build_string_from_tuple_list([], str), do: str
  defp build_string_from_tuple_list([{character, count}|tail], str) do
    new_string = str <> print_char_n_times(character, count)
    build_string_from_tuple_list(tail, new_string)
  end

  defp print_char_n_times(_, n \\ 1, str \\ "")
  defp print_char_n_times(_, 0, str), do: str
  defp print_char_n_times(character, n, str) do
    print_char_n_times(character, n - 1, str <> character)
  end

  defp parse_integer(x) do
     {count, _} = Integer.parse(x)
     count
  end
end
