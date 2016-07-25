defmodule School do
  @moduledoc """
  Simulate students in a school.

  Each student is in a grade.
  """

  @doc """
  Add a student to a particular grade in school.
  """
  @spec add(map, String.t, integer) :: map
  def add(db, name, grade) do
    current_grade = Map.get(db, grade, [])
    Map.put(db, grade, [name|current_grade])
  end

  @doc """
  Return the names of the students in a particular grade.
  """
  @spec grade(map, integer) :: [String.t]
  def grade(db, grade) do
    Map.get(db, grade, [])
  end

  @doc """
  Sorts the school by grade and name.
  """
  @spec sort(map) :: [{integer, [String.t]}]
  def sort(db) do
    grades = Map.keys(db)
              |> Enum.sort
              |> Enum.map(&grade_tuple(db, &1))
  end

  defp grade_tuple(db, grade) do
    students = Map.get(db, grade) |> Enum.sort

    { grade, students }
  end
end
