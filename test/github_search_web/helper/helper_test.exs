defmodule GithubSearchWeb.HelperTest do
  use ExUnit.Case, async: true

  doctest GithubSearch.Helper

  import GithubSearch.Helper

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

    expect(GithubProfileMock, :profile, fn "a" ->
      api_response
    end)

    assert ^api_response = GithubProfileMock.profile("a")
  end

  test "Convert json to maps" do
    json = ~s({"location": "Indonesia"})
    assert %{location: "Indonesia"} = decode_json(json)
  end

  test "Convert github api response time to expected string from '12 feb 2005' " do
    date_github_api = "2012-02-05T14:53:26Z"
    assert "5 Feb 2012" = format_time(date_github_api)
  end

  test "Get hex color from current used theme and data state" do
    theme = "dark"
    data = nil
    assert "#5E6D85" = icon_fill(data, theme)

    data = ""
    assert "#5E6D85" = icon_fill(data, theme)

    data = "Indonesia"
    assert "#A0B2CE" = icon_fill(data, theme)

    theme = "light"
    data = nil
    assert "#A0B2CE" = icon_fill(data, theme)

    data = ""
    assert "#A0B2CE" = icon_fill(data, theme)

    data = "Indonesia"
    assert "#5E6D85" = icon_fill(data, theme)
  end
end
