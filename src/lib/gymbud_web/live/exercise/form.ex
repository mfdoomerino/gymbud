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

  def handle_event("change", %{"workout" => workout}, socket) do
    changeset = Exercise.changeset(%Exercise{}, workout)
    {:noreply, assign(socket, %{
      create_params: workout,
      changeset: changeset
    })}
  end

  def handle_event("update_change", %{"workout" => workout}, socket) do
    changeset = Exercise.changeset(%Exercise{}, workout)
    {:noreply, assign(socket, %{
      update_params: workout
    })}
  end

  def handle_event("submit_workout", _params, %{assigns: assigns} = socket) do
    case Exercises.create_workout(assigns.create_params) do
      {:ok, workout} ->
        send(self(), {:create_workout, workout})
        {:noreply, socket}
      _ ->
        send(self(), :default_error)
        {:noreply, socket}
    end
  end

  def handle_event("update_workout", _params, %{assigns: assigns} = socket) do
    workout = Enum.find(assigns.workouts, & &1.id == assigns.update_params["id"])
    case Exercises.update_workout(workout, assigns.update_params) do
      {:ok, workout} ->
        send(self(), {:update_workout, workout})
        send(self(), :close_edit)
        {:noreply, socket}
      _ ->
        send(self(), :default_error)
        {:noreply, socket}
    end
  end
end
