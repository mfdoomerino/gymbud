defmodule GymbudWeb.ExerciseView do
  use GymbudWeb, :view

  def valid_changeset?(%{valid?: true}), do: true
  def valid_changeset?(_changeset), do: false
end
