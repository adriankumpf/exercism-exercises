defmodule Garden do

  @plants %{"V" => :violets, "R" => :radishes, "C" => :clover, "G" => :grass}
  @default_names ~w{ alice bob charlie david eve fred ginny harriet ileana joseph kincaid larry }a

  @doc """
  Accepts a string representing the arrangement of cups on a windowsill and a
  list with names of default_names in the class. The student names list does not
  have to be in alphabetical order.

  It decodes that string into the various gardens for each student and returns
  that information in a map.
  """

  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ @default_names) do
    sorted_student_names = Enum.sort(student_names)
    default_map = default_map(student_names)

    info_string
    |> group_plants_on_windowsill_by_student
    |> assign_plants_to_students(sorted_student_names)
    |> Enum.into(default_map)
  end

  defp group_row_by_students(row_string) do
    row_string
    |> String.graphemes
    |> Enum.map(fn p -> @plants[p] end)
    |> Enum.chunk(2, 2, [])
  end

  defp group_plants_on_windowsill_by_student(windowsill_string) do
    windowsill_string
    |> String.split("\n")
    |> Enum.map(&group_row_by_students(&1))
    |> List.zip
    |> Enum.map(fn plants -> List.to_tuple(elem(plants, 0) ++ elem(plants, 1)) end)
  end

  defp assign_plants_to_students(plants, students) do
    Enum.zip(students,  plants)
  end

  defp default_map(students) do
    students
    |> Enum.map(fn name -> {name, {}} end)
    |> Enum.into(%{})
  end

end
