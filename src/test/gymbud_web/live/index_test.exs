defmodule GymbudWeb.Live.IndexTest do
  use GymbudWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "initial render", %{conn: conn} do
    other_conn = get(conn, "/my-path")
    {:ok, _view, html} = live(conn, "/")
    assert html =~ "Let&#39;s get you started"
    # invokes mount

    IO.inspect(other_conn)
    IO.inspect(live(conn, "/"))
  end
end
