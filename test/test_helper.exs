Mox.defmock(GithubUsersBehaviourMock, for: GithubSearchWeb.Behaviour.GithubUsersBehaviour)
Application.put_env(:github_search, :helper, GithubUsersBehaviourMock)

ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(GithubSearch.Repo, :manual)
