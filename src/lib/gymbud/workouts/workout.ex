defmodule Gymbud.Workouts.Workout do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:workout_id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :workout_id}
  @foreign_key_type :binary_id

  schema "workout" do
    field :name, :string
    field :description, :string
    field :day, :string

    many_to_many(:exercises, Gymbud.Exercises.Exercise,
      join_through: "workout_exercises",
      join_keys: [workout_id: :workout_id, exercise_id: :exercise_id],
      on_replace: :delete
    )

    timestamps(type: :utc_datetime_usec)
  end

  @required [
    :name,
    :description,
    :day
  ]

  @doc false
  def changeset(workout, params \\ %{}) do
    workout
    |> cast(params, @required)
    |> cast_assoc(
      :exercises,
      required: false
    )
    |> validate_required(@required)
  end

  def update_changeset(workout, params \\ %{}) do
    exercise =
      case Gymbud.Exercises.get_exercise(%{"exercise_id" => params["exercise_id"]}) do
        {:ok, exercise} -> exercise
        _ -> nil
      end

    workout
    |> cast(params, @required)
    |> put_assoc(:exercises, [exercise | workout.exercises])
    |> validate_required(@required)
  end
end
