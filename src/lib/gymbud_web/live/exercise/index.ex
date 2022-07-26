defmodule ExerciseIndex do
  use Phoenix.LiveComponent

  def render(assigns) do
    Phoenix.View.render(GymbudWeb.ExerciseView, "index.html", assigns)
  end
end
