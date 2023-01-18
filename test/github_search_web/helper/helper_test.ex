defmodule GithubSearchWeb.HelperTest do
  use ExUnit.Case, async: true

  import Mox

  # Make sure mocks are verified when the test exits
  setup :verify_on_exit!

  test "Get user info based on given username" do
    expect(GithubUsersBehaviourMock, :user_search, fn "a" -> %{username: "a"} end)

    assert %{username: "a"} = GithubUsersBehaviourMock.user_search("a")
  end
end
