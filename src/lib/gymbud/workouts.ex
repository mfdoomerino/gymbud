defmodule Gymbud.Workouts do
  import Ecto.Query, warn: false
  alias Gymbud.Repo
  alias Gymbud.Workouts.Workout
  alias Gymbud.Queries.WorkoutQueries, as: WQ

  @preload [
    :exercises
  ]

  def list_workouts(params \\ %{}) do
    workouts =
      params
      |> WQ.query_all_workouts(@preload)
      |> Repo.all()

    {:ok, workouts}
  end

  def get_workout(params) do
    query = WQ.query_all_workouts(params, @preload)

    case Repo.one(query) do
      nil -> {:error, :not_found}
      workout -> {:ok, workout}
    end
  end

  def create_workout(attrs \\ %{}) do
    %Workout{}
    |> Workout.changeset(attrs)
    |> Repo.insert()
  end

  def update_workout(%Workout{} = workout, attrs) do
    workout
    |> Workout.update_changeset(attrs)
    |> Repo.update()
  end

  def delete_workout(%Workout{} = workout) do
    Repo.delete(workout)
  end
end
