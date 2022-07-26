defmodule Gymbud.ExercisesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Gymbud.Exercises` context.
  """

  @doc """
  Generate a exercise.
  """
  def exercise_fixture(attrs \\ %{}) do
    {:ok, workout} =
      Gymbud.Workouts.create_workout(%{
        "name" => "Test 1",
        "description" => "some desc",
        "day" => "Monday"
      })

    {:ok, exercise} =
      attrs
      |> Enum.into(%{
        name: "some name",
        reps: 42,
        sets: 42,
        weight: 42,
        workout_id: workout.workout_id
      })
      |> Gymbud.Exercises.create_exercise()

    exercise
  end
end
