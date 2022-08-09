defmodule Gymbud.Fixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Gymbud.Exercises` context.
  """

  @doc """
  Generate a exercise.
  """
  def exercise_fixture(attrs \\ %{}) do
    {:ok, exercise} =
      attrs
      |> Enum.into(%{
        name: "some name",
        reps: 42,
        sets: 42,
        weight: 42
      })
      |> Gymbud.Exercises.create_exercise()

    {:ok, exercise} = Gymbud.Exercises.get_exercise(%{"exercise_id" => exercise.exercise_id})
    exercise
  end

  def workout_fixture() do
    {:ok, workout} =
      Gymbud.Workouts.create_workout(%{
        "name" => "Test 1",
        "description" => "some desc",
        "day" => "Monday"
      })

    {:ok, workout} = Gymbud.Workouts.get_workout(%{"workout_id" => workout.workout_id})
    workout
  end
end
