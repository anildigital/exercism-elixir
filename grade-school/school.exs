defmodule School do
  @moduledoc """
  Simulate students in a school.

  Each student is in a grade.
  """

  @doc """
  Add a student to a particular grade in school.
  """
  @spec add([{atom, any}], String.t, atom) :: [{atom, any}]
  def add(db, name, grade) do
    map = Enum.into db, %{}
    updated_map = Map.update(map, grade, [name], fn (list) -> Enum.sort [name|list] end)
    Enum.into updated_map, []    
  end

  @doc """
  Return the names of the students in a particular grade.
  """
  @spec grade([{atom, any}], atom) :: any
  def grade(db, grade) do
    map = Enum.into db, %{}   
    Map.get(map, grade, [])   
  end

  @doc """
  Sorts the school by grade and name.
  """
  @spec sort([{atom, any}]) :: [{atom, any}]
  def sort(db) do
    Enum.sort db
  end
end
