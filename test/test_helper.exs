Mox.defmock(GithubProfileMock, for: GithubSearch.ProfileBehaviour)
Application.put_env(:github_search, :helper, GithubProfileMock)

ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(GithubSearch.Repo, :manual)
