defmodule Gymbud.Repo.Migrations.CreateWorkoutsTable do
  use Ecto.Migration

  def change do
    create table(:workout, primary_key: false) do
      add(:workout_id, :binary_id, primary_key: true)
      add(:name, :string, null: false)
      add(:description, :string, null: false)
      add(:day, :string, null: false)

      timestamps(type: :timestamptz)
    end
  end
end
