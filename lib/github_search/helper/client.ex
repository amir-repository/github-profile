defmodule GithubSearch.Helper.Client do
  @behaviour GithubSearch.ProfileBehaviour
  @impl GithubSearch.ProfileBehaviour
  def http_get_profile(url) do
    HTTPoison.get(url)
  end
end
