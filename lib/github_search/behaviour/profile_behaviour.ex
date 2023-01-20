defmodule GithubSearch.ProfileBehaviour do
  @type github_username :: String.t()
  @callback profile(github_username()) :: map()
end
