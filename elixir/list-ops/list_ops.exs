defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count([]), do: 0
  def count([h|t]) do
    count(t) + 1
  end

  @spec reverse(list) :: list
  def reverse(l) do
    _reverse(l, [])
  end

  defp _reverse([], acc), do: acc
  defp _reverse([h|t], acc), do: _reverse(t, [h|acc])

  @spec map(list, (any -> any)) :: list
  def map([], f), do: []
  def map([h|t], f) do
    [f.(h) | map(t, f)]
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter([], f), do: []
  def filter([h|t], f) do
    cond do
      f.(h) == true -> [h | filter(t, f)]
      true -> filter(t, f)
    end
  end

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce([], acc, f), do: acc
  def reduce([h|t], acc, f) do
    reduce(t, f.(h, acc), f)
  end

  @spec append(list, list) :: list
  def append([], b), do: b
  def append(a, []), do: a
  def append([h|t], b) do
    [h | append(t, b)]
  end

  @spec concat([[any]]) :: [any]
  def concat([]), do: []
  def concat([h|t]) when is_list(h) do
    append(concat(h), concat(t))
  end
  def concat([h|t]) do
    [h | concat(t)]
  end
end
