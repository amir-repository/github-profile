defmodule GithubSearch.Helper do
  @http_client Application.get_env(:github_search, :http_client)

  def profile(username) do
    api_url = "https://api.github.com/users/"
    {:ok, result} = @http_client.http_get_profile(api_url <> username)
    decode_json(result.body)
  end

  @behaviour GithubSearch.ProfileBehaviour
  @impl GithubSearch.ProfileBehaviour
  def http_get_profile(url) do
    HTTPoison.get(url)
  end

  @doc """
  Change json data format to elixir map with atom key

  ## Example
      iex> json = ~s({"location": "Indonesia"})
      iex> GithubSearch.Helper.decode_json(json)
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
      iex> GithubSearch.Helper.format_time(date_github_api)
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
      iex> GithubSearch.Helper.icon_fill(data, theme)
      "#5E6D85"
      iex> data = "Indonesia"
      iex> GithubSearch.Helper.icon_fill(data, theme)
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
