defmodule GymbudWeb.WorkoutView do
  use GymbudWeb, :view
  use Ecto.Schema

  alias Gymbud.Workouts.Workout
  import Ecto.Changeset

  def days(), do: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

  def valid_changeset?(%{valid?: true}), do: true
  def valid_changeset?(_changeset), do: false
end
