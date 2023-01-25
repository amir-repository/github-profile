defmodule GithubSearch.ProfileBehaviour do
  @callback http_get_profile(url :: String.t()) ::
              {:ok, response :: map()} | {:error, reason :: term()}
end
