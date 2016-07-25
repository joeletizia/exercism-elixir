defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t
  def verse(1) do
    """
    No more bottles of beer on the wall, no more bottles of beer.
    Go to the store and buy some more, 99 bottles of beer on the wall.
    """
  end
  def verse(2) do
    """
    1 bottle of beer on the wall, 1 bottle of beer.
    Take it down and pass it around, no more bottles of beer on the wall.
    """
  end
  def verse(3) do
    """
    2 bottles of beer on the wall, 2 bottles of beer.
    Take one down and pass it around, 1 bottle of beer on the wall.
    """
  end
  def verse(number) do
    """
    #{number-1} bottles of beer on the wall, #{number-1} bottles of beer.
    Take one down and pass it around, #{number-2} bottles of beer on the wall.
    """
  end

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t) :: String.t
  def lyrics(range) do
    Enum.to_list(range)
    |> Enum.map(fn(i) -> verse(i) <> "\n" end)
    |> Enum.join
    |> remove_trailing_return
  end

  def lyrics do
    lyrics(100..1)
  end

  defp remove_trailing_return(string) do
    end_of_string = String.length(string) - 2
    String.slice(string, 0..end_of_string)
  end
end
