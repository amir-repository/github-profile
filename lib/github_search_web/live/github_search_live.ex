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
  Change the icon fill color based on selected theme

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

  @doc """
  Change json data format to elixir map with atom key

  ## Example
      iex> json = ~s({"location": "Indonesia"})
      iex> GithubSearchWeb.GithubSearchLive.decode_json(json)
      %{location: "Indonesia"}
  """
  def decode_json(json) do
    {:ok, result} = Jason.decode(json, keys: :atoms)
    result
  end

  @doc """
  Change complete time format from github API `2012-02-05T14:53:26Z` to expected UI time format `5 Feb 2012`

  ## Example
      iex> date_github_api = "2012-02-05T14:53:26Z"
      iex> GithubSearchWeb.GithubSearchLive.format_time(date_github_api)
      "5 Feb 2012"

  """
  def format_time(strftime_str) do
    {:ok, datetime} = Timex.parse(strftime_str, "{ISO:Extended}")

    datetime
    |> Timex.format!("{D} {Mshort} {YYYY}")
  end
end
