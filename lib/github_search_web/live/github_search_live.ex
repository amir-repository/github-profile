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
      user_search(username)
      |> Map.put(:username, username)

    user = %{user | created_at: format_time(user.created_at)}
    IO.inspect(user)
    {:noreply, assign(socket, :user, user)}
  end

  @doc """
  change the icon fill color based on selected theme

  ## Example
      iex> theme = "dark"
      iex> data = nil
      iex> GithubSearchWeb.GithubSearchLive.icon_fill(data, theme)
      "#5E6D85"
      iex> data = "Indonesia"
      iex> GithubSearchWeb.GithubSearchLive.icon_fill(data, theme)
      "#A0B2CE"
  """

  def icon_fill(data, theme) do
    case theme do
      "dark" ->
        case data do
          nil -> "#5E6D85"
          "" -> "#5E6D85"
          _ -> "#A0B2CE"
        end

      "light" ->
        case data do
          nil -> "#A0B2CE"
          "" -> "#A0B2CE"
          _ -> "#5E6D85"
        end
    end
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
