defmodule ExerciseForm do
  use Phoenix.LiveComponent

  alias Gymbud.Exercises
  alias Gymbud.Exercises.Exercise

  def update(assigns, socket), do: {:ok, assign(socket, assigns)}

  def render(%{type: "update"} = assigns) do
    Phoenix.View.render(GymbudWeb.ExerciseView, "update_form.html", assigns)
  end

  def render(%{type: "create"} = assigns) do
    Phoenix.View.render(GymbudWeb.ExerciseView, "create_form.html", assigns)
  end

  def handle_event("change", %{"exercise" => exercise}, socket) do
    changeset = Exercise.changeset(%Exercise{}, exercise)
    {:noreply, assign(socket, %{
      create_params: exercise,
      changeset: changeset
    })}
  end

  def handle_event("submit_exercise", _params, %{assigns: assigns} = socket) do
    case Exercises.create_exercise(assigns.create_params) do
      {:ok, _exercise} ->
        send(self(), :create_exercise)
        {:noreply, socket}
      _ ->
        send(self(), :default_error)
        {:noreply, socket}
    end
  end
end
