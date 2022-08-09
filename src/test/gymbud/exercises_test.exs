defmodule Gymbud.ExercisesTest do
  use Gymbud.DataCase

  alias Gymbud.Exercises
  alias Gymbud.Workouts
  import Gymbud.Fixtures
  # @invalid_attrs %{name: nil, reps: nil, sets: nil, weight: nil}

  describe "exercises" do
    test "list_exercises/0 returns all exercises" do
      workout = workout_fixture()
      exercise = exercise_fixture()

      assert workout.name == "Test 1"
      assert {:ok, workout} = Workouts.update_workout(workout, %{"exercise_id" => exercise.exercise_id})
    end
  end
end
