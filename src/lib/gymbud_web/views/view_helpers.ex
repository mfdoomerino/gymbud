defmodule GymbudWeb.ViewHelpers do
  use Phoenix.HTML

  def workouts() do
    ["Push", "Pull", "Upper", "Lower"]
  end
end
