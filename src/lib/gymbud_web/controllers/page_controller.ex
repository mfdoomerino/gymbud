defmodule GymbudWeb.PageController do
  use GymbudWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
