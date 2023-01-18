defmodule GithubSearchWeb.Behaviour.GithubUsersBehaviour do
  @type github_username :: String.t()
  @callback user_search(github_username()) :: map()
end
