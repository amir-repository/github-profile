defmodule GithubSearchWeb.Helper.ClientTest do
  use ExUnit.Case, async: true

  import GithubSearch.Helper.Client

  import Mox

  setup :verify_on_exit!

  test "Get user info based on given username" do
    api_response = %{
      name: "api_response",
      username: "a",
      avatar_url: "https://avatars.githubusercontent.com/u/1410106?v=4",
      created_at: "5 Feb 2012",
      bio: "",
      public_repos: 26,
      followers: 529,
      following: 149,
      location: "Ho Chi Minh, Vietnam",
      blog: "http://anto.sh",
      twitter_username: nil,
      company: nil
    }

    Mox.stub(GithubSearch.Helper.ClientMock, :http_get_profile, fn _url ->
      {:ok, api_response}
    end)

    http_get_profile("a") == api_response
  end
end
