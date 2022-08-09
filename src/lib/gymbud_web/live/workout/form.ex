defmodule WorkoutForm do
  use Phoenix.LiveComponent

  alias Gymbud.Workouts
  alias Gymbud.Workouts.Workout
  import GymbudWeb.ViewHelpers

  def mount(socket) do
    assigns = %{
      matches: [],
      update_params: %{}
    }
    {:ok, assign(socket, assigns)}
  end

  def update(assigns, socket) do
    socket =
      if assigns.type == "update" do
        update_changeset = create_update_changeset(assigns.workout)
        socket =
          socket
          |> assign(assigns)
          |> assign(update_changeset: update_changeset)
      else
        assign(socket, assigns)
      end

    {:ok, socket}
  end

  def render(%{type: "update"} = assigns) do
    Phoenix.View.render(GymbudWeb.WorkoutView, "update_form.html", assigns)
  end

  def render(%{type: "create"} = assigns) do
    Phoenix.View.render(GymbudWeb.WorkoutView, "create_form.html", assigns)
  end

  def handle_event("change", %{"workout" => workout}, socket) do
    changeset = Workout.changeset(%Workout{}, workout)
    {:noreply, assign(socket, %{
      create_params: workout,
      changeset: changeset,
      matches: suggest(workout["name"])
    })}
  end

  def handle_event("update_change", %{"workout" => workout}, socket) do
    changeset = Workout.update_changeset(%Workout{}, workout)
    {:noreply, assign(socket, %{
      update_params: workout,
      update_changeset: changeset
    })}
  end

  def handle_event("submit_workout", _params, %{assigns: assigns} = socket) do
    case Workouts.create_workout(assigns.create_params) do
      {:ok, _workout} ->
        send(self(), :create_workout)
        {:noreply, socket}
      _ ->
        send(self(), :default_error)
        {:noreply, socket}
    end
  end

  def handle_event("update_workout", _params, %{assigns: assigns} = socket) do
    case Workouts.update_workout(assigns.workout, assigns.update_params) do
      {:ok, workout} ->
        send(self(), {:update_workout, workout})
        send(self(), :close_edit)
        {:noreply, socket}
      _ ->
        send(self(), :default_error)
        {:noreply, socket}
    end
  end

  defp suggest(string) do
    Enum.filter(workouts(), &(String.downcase(&1) =~ String.downcase(string)))
  end

  defp create_update_changeset(resource) do
    params_map = Map.from_struct(resource)
    Workout.update_changeset(%Workout{}, params_map)
  end
end
