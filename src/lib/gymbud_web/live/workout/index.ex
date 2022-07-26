defmodule WorkoutIndex do
  use Phoenix.LiveComponent
  alias Gymbud.Workouts
  alias Gymbud.Workouts.Workout

  def render(assigns) do
    Phoenix.View.render(GymbudWeb.WorkoutView, "index.html", assigns)
  end

  def update(assigns, socket) do
    socket = assign(socket, assigns)
    {:ok, socket}
  end
end
