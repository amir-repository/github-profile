defmodule GithubSearchWeb.GithubSearchLiveTest do
  use GithubSearchWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "Initial theme", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/")

    assert render(view) =~ String.capitalize("DARK")
  end
end
