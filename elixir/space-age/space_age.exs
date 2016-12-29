defmodule SpaceAge do
  @type planet :: :mercury | :venus | :earth | :mars | :jupiter
                | :saturn | :uranus | :neptune

  @earth_year_s 31557600

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet'.
  """
  @spec age_on(planet, pos_integer) :: float
  def age_on(planet, seconds), do: do_age_on(planet, seconds)

  def do_age_on(:earth, seconds), do: seconds / @earth_year_s
  def do_age_on(:mercury, seconds), do: seconds / (@earth_year_s * 0.2408467)
  def do_age_on(:venus, seconds), do: seconds / (@earth_year_s * 0.61519726)
  def do_age_on(:mars, seconds), do: seconds / (@earth_year_s * 1.8808158)
  def do_age_on(:jupiter, seconds), do: seconds / (@earth_year_s * 11.862615)
  def do_age_on(:saturn, seconds), do: seconds / (@earth_year_s * 29.447498)
  def do_age_on(:uranus, seconds), do: seconds / (@earth_year_s * 84.016846)
  def do_age_on(:neptune, seconds), do: seconds / (@earth_year_s * 164.79132)

end
