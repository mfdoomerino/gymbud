defmodule Gymbud.Exercises.Exercise do
  use Ecto.Schema
  import Ecto.Changeset
  alias Gymbud.Workouts.Workout

  @primary_key {:exercise_id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :exercise_id}

  schema "exercise" do
    field :name, :string
    field :reps, :integer
    field :sets, :integer
    field :weight, :integer

    belongs_to(:workout, Workout,
      references: :workout_id,
      foreign_key: :workout_id
    )

    timestamps(type: :utc_datetime_usec)
  end

  @attrs [
    :name,
    :sets,
    :reps,
    :weight,
    :workout_id
  ]

  @doc false
  def changeset(exercise, attrs) do
    exercise
    |> cast(attrs, @attrs)
    |> validate_required(@attrs)
  end
end
