defmodule Gymbud.Exercises.Exercise do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:exercise_id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :exercise_id}
  @foreign_key_type :binary_id

  schema "exercise" do
    field :name, :string
    field :reps, :integer
    field :sets, :integer
    field :weight, :integer

    many_to_many(:workouts, Gymbud.Workouts.Workout,
      join_through: "workout_exercises",
      join_keys: [exercise_id: :exercise_id, workout_id: :workout_id],
      on_replace: :delete
    )

    timestamps(type: :utc_datetime_usec)
  end

  @required [
    :name,
    :sets,
    :reps,
    :weight
  ]

  @doc false
  def changeset(exercise, attrs \\ %{}) do
    exercise
    |> cast(attrs, @required)
    |> cast_assoc(
      :workouts,
      required: false
    )
    |> validate_required(@required)
  end
end
