defmodule BracketPush do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """

  @opening_brackets ["[", "{", "("]
  @closing_brackets ["]", "}", ")"]

  @valid_matches %{"]" => "[", "}" => "{", ")" => "("}

  @spec check_brackets(String.t) :: boolean
  def check_brackets(""), do: true
  def check_brackets(string) do
    String.graphemes(string)
    |> Enum.filter(fn(x) -> Enum.member?(@opening_brackets ++ @closing_brackets, x) end)
    |> check_brackets_helper([])
  end

  defp check_brackets_helper([], []), do: true
  defp check_brackets_helper([], _), do: false
  defp check_brackets_helper([head|_], []) when head in @closing_brackets, do: false

  defp check_brackets_helper([head|tail], current_list) when head in @opening_brackets do
    check_brackets_helper(tail, [head] ++ current_list)
  end

  defp check_brackets_helper([x|y], [head|tail]) when x in @closing_brackets do
    matched_opening = Map.get(@valid_matches, x)

    cond do
      matched_opening === head -> check_brackets_helper(y, tail)
      true                     -> false
    end
  end
end
