defmodule GymbudWeb.Live.IndexTest do
  use GymbudWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "initial render", %{conn: conn} do
    {:ok, view, html} = live(conn, "/")
    assert html =~ "Let&#39;s get you started"
    # invokes mount
  end
end
