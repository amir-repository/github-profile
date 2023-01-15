defmodule GithubSearchWeb.GithubSearchLive do
  use GithubSearchWeb, :live_view

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
     |> assign(:dark_theme, true)}
  end

  def handle_event("toggle_theme", _params, socket) do
    socket = assign(socket, :dark_theme, !socket.assigns.dark_theme)
    IO.inspect(socket.assigns.dark_theme)
    {:noreply, socket}
  end

  def handle_event("search_username", %{"username" => username}, socket) do
    user =
      user_search(username)
      |> Map.put(:username, username)

    user = %{user | created_at: format_time(user.created_at)}
    {:noreply, assign(socket, :user, user)}
  end

  defp user_search(username) do
    api_url = "https://api.github.com/users/"
    {:ok, result} = HTTPoison.get(api_url <> username)
    decode_json(result.body)
  end

  defp decode_json(json) do
    {:ok, result} = Jason.decode(json, keys: :atoms)
    result
  end

  defp format_time(strftime_str) do
    {:ok, datetime} = Timex.parse(strftime_str, "{ISO:Extended}")

    datetime
    |> Timex.format!("{D} {Mshort} {YYYY}")
  end

  def format_time_on_map(map) do
    %{map | created_at: format_time(map.time)}
  end
end
