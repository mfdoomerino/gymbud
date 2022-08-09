defmodule ExerciseIndex do
  use Phoenix.LiveComponent

  def render(assigns) do
    Phoenix.View.render(GymbudWeb.ExerciseView, "index.html", assigns)
  end

  def update(assigns, socket), do: {:ok, assign(socket, assigns)}
end
