defmodule Pagination do
  use Phoenix.LiveComponent

  def render(assigns) do
    Phoenix.View.render(GymbudWeb.AppView, "pagination.html", assigns)
  end

  def update(assigns, socket) do
    socket = assign(socket, assigns)
    {:ok, socket}
  end
end
