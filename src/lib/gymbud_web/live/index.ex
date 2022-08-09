defmodule GymbudWeb.AppLive do
  use GymbudWeb, :live_view
  alias Gymbud.Workouts
  alias Gymbud.Exercises
  alias Gymbud.Workouts.Workout
  alias Gymbud.Exercises.Exercise

  on_mount {MyAppWeb.OnMount, :admin}

  def mount(_params,_, socket) do
    workout_changeset = Workout.changeset(%Workout{})
    exercise_changeset = Exercise.changeset(%Exercise{})

    defaults = %{
      workout_changeset: workout_changeset,
      exercise_changeset: exercise_changeset,
      create_params: %{},
      workouts: [],
      exercises: [],
      total_workouts: 0,
      total_exercises: 0,
      editing: [],
      section: :workout,
      has_next: false,
      pagination_options: %{
        "page" => 1,
        "per_page" => 3
      }
    }

    socket = assign(socket, defaults)
    if connected?(socket), do: send(self(), :load)

    {:ok, socket}
  end

  def render(assigns) do
    Phoenix.View.render(GymbudWeb.AppView, "index.html", assigns)
  end

  def handle_info(:load, socket) do
    socket = assign(socket, %{
      workouts: set_workouts(socket.assigns.pagination_options),
      exercises: set_exercises(socket.assigns.pagination_options),
      total_workouts: Enum.count(set_workouts(%{})),
      total_exercises: Enum.count(set_exercises(%{}))
    })

    {_, has_next} = determine_next(socket.assigns.pagination_options, socket.assigns.section, socket.assigns)

    {:noreply, assign(socket, has_next: has_next)}
  end

  def handle_info(:create_workout, %{assigns: assigns} = socket) do
    socket =
      socket
      |> assign(workouts: set_workouts(assigns.pagination_options))
      |> put_flash(:info, "Workout created successfully")

    {:noreply, socket}
  end

  def handle_info(:create_exercise, %{assigns: assigns} = socket) do
    socket =
      socket
      |> assign(exercises: set_exercises(assigns.pagination_options))
      |> put_flash(:info, "Exercise created successfully")

    {:noreply, socket}
  end

  def handle_info({:update_workout, _workout}, %{assigns: assigns} = socket) do
    socket =
      socket
      |> assign(workouts: set_workouts(assigns.pagination_options))
      |> put_flash(:info, "Workout updated successfully")

    {:noreply, socket}
  end

  def handle_info(:close_edit, socket) do
    assigns = %{
      editing: []
    }

    {:noreply, assign(socket, assigns)}
  end

  def handle_info(:default_error, socket), do: {:noreply, put_flash(socket, :error, "Something went wrong")}

  def handle_event("edit_workout", %{"id" => id}, %{assigns: assigns} = socket) do
    editing = Enum.uniq(assigns.editing ++ [id])
    {:noreply, assign(socket, editing: editing)}
  end

  def handle_event("delete_workout", %{"id" => id}, %{assigns: assigns} = socket) do
    workout = Enum.find(assigns.workouts, & &1.workout_id == id)

    case Workouts.delete_workout(workout) do
      {:ok, _workout} ->
        socket = assign(socket, workouts: set_workouts(socket.assigns.pagination_options))
        {:noreply, put_flash(socket, :info, "Workout deleted successfully")}
      _ ->
        {:noreply, put_flash(socket, :error, "Something went wrong")}
    end
  end

  def handle_event("delete_exercise", %{"id" => id}, %{assigns: assigns} = socket) do
    exercise = Enum.find(assigns.exercises, & &1.exercise_id == id)

    case Exercises.delete_exercise(exercise) do
      {:ok, _workout} ->
        socket = assign(socket, exercises: set_exercises(socket.assigns.pagination_options))
        {:noreply, put_flash(socket, :info, "Exercise deleted successfully")}
      _ ->
        {:noreply, put_flash(socket, :error, "Something went wrong")}
    end
  end

  def handle_params(%{"section" => section}, _uri, socket) do
    {:noreply, assign(socket, section: String.to_atom(section))}
  end

  def handle_params(%{"page" => page, "per_page" => per_page}, _uri, socket) do
    page = if is_integer(page), do: page, else: String.to_integer(page)
    per_page = if is_integer(per_page), do: per_page, else: String.to_integer(per_page)
    options = %{
      "page" => page,
      "per_page" => per_page
    }

    {resources, has_next} = determine_next(options, socket.assigns.section, socket.assigns)

    section =
      if socket.assigns.section == :workout do
        "workouts"
      else
        "exercises"
      end

    {:noreply,
      assign(socket, %{
        pagination_options: options,
        "#{section}": resources,
        has_next: has_next
      }
    )}
  end

  def handle_params(_, _uri, socket) do
    {:noreply, socket}
  end

  defp set_workouts(params) do
    case Workouts.list_workouts(params) do
      {:ok, wos} -> wos
      _ -> []
    end
  end

  defp set_exercises(params) do
    case Exercises.list_exercises(params) do
      {:ok, exercises} -> exercises
      _ -> []
    end
  end

  defp determine_next(params, section, assigns) do
    {resources, total} =
      if section == :workout do
        {set_workouts(params), assigns.total_workouts}
      else
        {set_exercises(params), assigns.total_exercises}
      end

    total = Float.ceil(total/3)

    {resources, params["page"] < total}
  end
end
