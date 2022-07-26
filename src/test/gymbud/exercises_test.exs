defmodule Gymbud.ExercisesTest do
  use Gymbud.DataCase

  alias Gymbud.Exercises

  describe "exercises" do
    alias Gymbud.Exercises.Exercise

    import Gymbud.ExercisesFixtures

    @invalid_attrs %{name: nil, reps: nil, sets: nil, weight: nil}

    test "list_exercises/0 returns all exercises" do
      exercise = exercise_fixture()
      assert Exercises.list_exercises() == [exercise]
    end

  #   test "get_exercise!/1 returns the exercise with given id" do
  #     exercise = exercise_fixture()
  #     assert Exercises.get_exercise!(exercise.id) == exercise
  #   end

  #   test "create_exercise/1 with valid data creates a exercise" do
  #     valid_attrs = %{name: "some name", reps: 42, sets: 42, weight: 42}

  #     assert {:ok, %Exercise{} = exercise} = Exercises.create_exercise(valid_attrs)
  #     assert exercise.name == "some name"
  #     assert exercise.reps == 42
  #     assert exercise.sets == 42
  #     assert exercise.weight == 42
  #   end

  #   test "create_exercise/1 with invalid data returns error changeset" do
  #     assert {:error, %Ecto.Changeset{}} = Exercises.create_exercise(@invalid_attrs)
  #   end

  #   test "update_exercise/2 with valid data updates the exercise" do
  #     exercise = exercise_fixture()
  #     update_attrs = %{name: "some updated name", reps: 43, sets: 43, weight: 43}

  #     assert {:ok, %Exercise{} = exercise} = Exercises.update_exercise(exercise, update_attrs)
  #     assert exercise.name == "some updated name"
  #     assert exercise.reps == 43
  #     assert exercise.sets == 43
  #     assert exercise.weight == 43
  #   end

  #   test "update_exercise/2 with invalid data returns error changeset" do
  #     exercise = exercise_fixture()
  #     assert {:error, %Ecto.Changeset{}} = Exercises.update_exercise(exercise, @invalid_attrs)
  #     assert exercise == Exercises.get_exercise!(exercise.id)
  #   end

  #   test "delete_exercise/1 deletes the exercise" do
  #     exercise = exercise_fixture()
  #     assert {:ok, %Exercise{}} = Exercises.delete_exercise(exercise)
  #     assert_raise Ecto.NoResultsError, fn -> Exercises.get_exercise!(exercise.id) end
  #   end

  #   test "change_exercise/1 returns a exercise changeset" do
  #     exercise = exercise_fixture()
  #     assert %Ecto.Changeset{} = Exercises.change_exercise(exercise)
  #   end
  end
end
