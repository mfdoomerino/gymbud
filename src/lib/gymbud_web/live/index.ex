defmodule GymbudWeb.AppLive do
  use GymbudWeb, :live_view
  alias Gymbud.Workouts
  alias Gymbud.Workouts.Workout

  # TODO: Optimize last page identification
  # TODO: Update form changeset validation

  on_mount {MyAppWeb.OnMount, :admin}

  def mount(_params,_, socket) do
    changeset = Workout.changeset(%Workout{})

    defaults = %{
      changeset: changeset,
      create_params: %{},
      workouts: [],
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
      changeset: socket.assigns.changeset,
      create_params: %{},
      workouts: set_workouts(socket.assigns.pagination_options),
      has_next: determine_next(socket.assigns.pagination_options)
    })

    {:noreply, socket}
  end

  def handle_info({:create_workout, workout}, %{assigns: assigns} = socket) do
    socket =
      socket
      |> assign(workouts: assigns.workouts ++ [workout])
      |> put_flash(:info, "Workout created successfully")

    {:noreply, socket}
  end

  def handle_info({:update_workout, workout}, %{assigns: assigns} = socket) do
    workouts =
      Enum.map(assigns.workouts, fn w ->
        if w.workout_id == workout.workout_id do
          workout
        else
          w
        end
      end)

    socket =
      socket
      |> assign(workouts: workouts)
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
        socket = assign(socket, workouts: Enum.filter(assigns.workouts, & &1.workout_id !== id))
        {:noreply, put_flash(socket, :info, "Workout deleted successfully")}
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

    has_next = determine_next(%{
      "page" => page,
      "per_page" => per_page
    })

    {:noreply, assign(socket, %{
      pagination_options: options,
      workouts: set_workouts(options),
      has_next: has_next
    })}
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

  defp determine_next(params) do
    params = %{
      "page" => params["page"] + 1,
      "per_page" => params["per_page"]
    }

    wos = set_workouts(params)
    wos !== []
  end
end
