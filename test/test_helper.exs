Mox.defmock(GithubSearch.HelperMock, for: GithubSearch.ProfileBehaviour)

ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(GithubSearch.Repo, :manual)
