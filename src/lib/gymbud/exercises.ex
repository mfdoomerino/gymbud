defmodule Gymbud.Exercises do
  import Ecto.Query, warn: false
  alias Gymbud.Repo
  alias Gymbud.Exercises.Exercise
  alias Gymbud.Queries.ExerciseQueries, as: EQ

  @preload [
    :workouts
  ]

  def list_exercises(params \\ %{}) do
    exercises =
      params
      |> EQ.query_all_exercises(@preload)
      |> Repo.all()

    {:ok, exercises}
  end

  def get_exercise(params) do
    query = EQ.query_all_exercises(params, @preload)

    case Repo.one(query) do
      nil -> {:error, :not_found}
      exercise -> {:ok, exercise}
    end
  end

  def create_exercise(attrs \\ %{}) do
    %Exercise{}
    |> Exercise.changeset(attrs)
    |> Repo.insert()
  end

  def update_exercise(%Exercise{} = exercise, attrs) do
    exercise
    |> Exercise.changeset(attrs)
    |> Repo.update()
  end

  def delete_exercise(%Exercise{} = exercise) do
    Repo.delete(exercise)
  end
end
