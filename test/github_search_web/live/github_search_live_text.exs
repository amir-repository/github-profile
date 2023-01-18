defmodule GithubSearchWeb.GithubSearchLiveTest do
  use GithubSearchWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "Dark/Light theme toogle", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/")

    assert render(view) =~ String.capitalize("DARK")
    assert render(view) =~ "icon-moon.svg"
    assert render(view) =~ "class=\"light\""

    assert view |> element("#toggle_theme") |> render_click() =~ String.capitalize("LIGHT")
    assert view |> element("#toggle_theme") |> render_click() =~ "icon-moon.svg"
    assert view |> element("#toggle_theme") |> render_click() =~ "class=\"dark\""
  end

  test "Search github profile by username", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/")

    username = "a"

    view
    |> form("form", %{username: username})
    |> render_submit()

    assert has_element?(view, "#username", username)
  end
end
