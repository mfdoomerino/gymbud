defmodule Gymbud.Repo.Migrations.RecreateTables do
  use Ecto.Migration

  def change do
    execute("""
      DROP TABLE if exists exercise cascade;
    """)
    create table(:exercise, primary_key: false) do
      add(:exercise_id, :binary_id, primary_key: true, default: fragment("uuid_generate_v4()"))
      add(:workout_id, references(:workout, column: :workout_id, type: :uuid),
        null: true
      )
      add(:name, :string, null: false)
      add(:sets, :integer, null: false)
      add(:reps, :integer, null: false)
      add(:weight, :integer, null: false)

      timestamps(type: :timestamptz)
    end

    create table(:workout_exercises, primary_key: false) do
      add :exercise_id, references(:exercise, column: :exercise_id, type: :uuid)
      add :workout_id, references(:workout, column: :workout_id, type: :uuid)
    end
  end
end
