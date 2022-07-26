defmodule Gymbud.Workouts.Workout do
  use Ecto.Schema
  import Ecto.Changeset
  alias Gymbud.Exercises.Exercise

  @primary_key {:workout_id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :workout_id}
  @foreign_key_type :binary_id

  schema "workout" do
    field :name, :string
    field :description, :string
    field :day, :string
    has_many(:exercises, Exercise,
      foreign_key: :exercise_id,
      on_replace: :delete
    )

    timestamps(type: :utc_datetime_usec)
  end

  @attrs [
    :name,
    :description,
    :day
  ]

  @update_attrs [
    :workout_id
  ]

  @doc false
  def changeset(workout, params \\ %{}) do
    workout
    |> cast(params, @attrs)
    |> validate_required(@attrs)
  end

  def update_changeset(workout, params \\ %{}) do
    workout
    |> cast(params, @attrs ++ @update_attrs)
    |> validate_required(@attrs)
  end
end
