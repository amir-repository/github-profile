Mox.defmock(GithubSearch.Helper.ClientMock, for: GithubSearch.ProfileBehaviour)

ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(GithubSearch.Repo, :manual)
