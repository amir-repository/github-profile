defmodule GithubSearchWeb.GithubSearchLive do
  use GithubSearchWeb, :live_view
  alias GithubSearchWeb.Helper

  def helper, do: Application.get_env(:github_search, :helper)

  def mount(_params, _session, socket) do
    {:ok,
     assign(socket, :user, %{
       name: nil,
       username: nil,
       avatar_url: nil,
       created_at: nil,
       bio: nil,
       public_repos: nil,
       followers: nil,
       following: nil,
       location: nil,
       blog: nil,
       twitter_username: nil,
       company: nil
     })
     |> assign(:theme, "light")}
  end

  def handle_event("toggle_theme", _params, socket) do
    case socket.assigns.theme do
      "dark" ->
        socket = assign(socket, :theme, "light")
        {:noreply, socket}

      "light" ->
        socket = assign(socket, :theme, "dark")
        {:noreply, socket}
    end
  end

  def handle_event("search_username", %{"username" => username}, socket) do
    user =
      helper().user_search(username)
      |> Map.put(:username, username)

    user = %{user | created_at: helper().format_time(user.created_at)}
    {:noreply, assign(socket, :user, user)}
  end
end
