defmodule MyAppWeb.OnMount do
  import Phoenix.LiveView

  def on_mount(:admin, _params, _session, socket) do
    {:cont, assign(socket, current_user: "Nick")}
  end

  def on_mount(:user, _params, _session, socket) do
    {:cont, assign(socket, current_user: "Visitor")}
  end

  def on_mount(:default, _params, _session, socket) do
    # some hook for auth
    # if true do
    #   {:cont, socket}
    # else
    #   {:halt, redirect(socket, to: "/login")}
    # end

    {:cont, socket}
  end
end
