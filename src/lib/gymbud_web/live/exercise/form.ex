defmodule ExerciseForm do
  use Phoenix.LiveComponent

  alias Gymbud.Exercises
  alias Gymbud.Exercises.Exercise

  def render(%{type: "update"} = assigns) do
    Phoenix.View.render(GymbudWeb.ExerciseView, "update_form.html", assigns)
  end

  def render(%{type: "create"} = assigns) do
    Phoenix.View.render(GymbudWeb.ExerciseView, "create_form.html", assigns)
  end
end
