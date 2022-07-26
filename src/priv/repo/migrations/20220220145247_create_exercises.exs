defmodule Gymbud.Repo.Migrations.CreateExercises do
  use Ecto.Migration

  def change do
    create table(:exercise, primary_key: false) do
      add(:exercise_id, :binary_id, primary_key: true, default: fragment("uuid_generate_v4()"))
      add(:name, :string, null: false)
      add(:sets, :integer, null: false)
      add(:reps, :integer, null: false)
      add(:weight, :integer, null: false)

      add(:workout_id, references(:workout, column: :workout_id, type: :uuid),
        null: false
      )

      timestamps(type: :timestamptz)
    end
  end
end
