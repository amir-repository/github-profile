defmodule GithubSearchWeb.Helper do
  @behaviour GithubSearchWeb.Behaviour.GithubUsersBehaviour

  @impl GithubSearchWeb.Behaviour.GithubUsersBehaviour
  def user_search(username) do
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
end
