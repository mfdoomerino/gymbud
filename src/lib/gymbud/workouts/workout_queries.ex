defmodule Gymbud.Queries.WorkoutQueries do
  import Ecto.Query
  alias Gymbud.Workouts.Workout

  def query_all_workouts(params \\ %{}, preload \\ []) do
    query = from(w in Workout, preload: ^preload)
    query = from(q in query, order_by: [desc: q.inserted_at])

    query_by(query, params)
  end

  defp query_by(query, %{"page" => page, "per_page" => per_page} = params) do
    query =
      from(q in query,
        offset: ^((page - 1) * per_page),
        limit: ^per_page
      )

    query_by(query, Map.drop(params, ["page", "per_page"]))
  end

  defp query_by(query, %{"sort" => "inserted_at_asc"} = params) do
    query = from(q in query, order_by: [asc: q.inserted_at])

    query_by(query, Map.delete(params, "sort"))
  end

  defp query_by(query, %{"sort" => "inserted_at_desc"} = params) do
    query = from(q in query, order_by: [desc: q.inserted_at])

    query_by(query, Map.delete(params, "sort"))
  end

  defp query_by(query, %{"workout_id" => id} = params) do
    query = from(q in query, where: q.workout_id == ^id)

    query_by(query, Map.delete(params, "workout_id"))
  end

  defp query_by(query, _), do: query

  # alternative https://hexdocs.pm/ecto/Ecto.Query.html
  # defp build_dynamic(params) do
  #   Enum.reduce(params, dynamic(true), fn
  #     {"workout_id", id}, dynamic ->
  #       dynamic([e], ^dynamic and e.workout_id == ^id)

  #     {"name", name}, dynamic ->
  #       dynamic([e], ^dynamic and e.name == ^name)

  #     _, dynamic ->
  #       dynamic
  #   end)
  # end
end
