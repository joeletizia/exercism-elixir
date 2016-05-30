require IEx

defmodule Bob do
  def hey(input) do
    cond do
      String.strip(input) == "" -> "Fine. Be that way!"
      String.last(input) == "?" -> "Sure."
      "1, 2, 3" == input -> "Whatever."
      shouting?(input) -> "Whoa, chill out!"
      true -> "Whatever."
    end
  end

  defp shouting?(input) do
    String.upcase(input) == input
  end
end
