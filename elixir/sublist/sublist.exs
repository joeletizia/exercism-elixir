defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """

  def compare(left, right) when left === right, do: :equal

  def compare(left, right) do
    cond do
      sublist?(left, right) -> :sublist
      sublist?(right, left) -> :superlist
      true                  -> :unequal
    end
  end

  defp sublist?([], _), do: true
  defp sublist?(_, []), do: false
  defp sublist?(left, right) when length(left) > length(right), do: false
  defp sublist?(left, right) do
    cond do
      left === Enum.take(right, length(left)) -> true
      true                                    -> sublist?(left, tl(right))
    end
  end
end
