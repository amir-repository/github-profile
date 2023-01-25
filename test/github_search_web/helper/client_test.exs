defmodule GithubSearchWeb.Helper.ClientTest do
  use ExUnit.Case, async: true

  import GithubSearch.Helper
  import GithubSearch.Helper.Client

  import Mox

  setup :verify_on_exit!

  test "Get user info based on given username" do
    api_response = %{
      avatar_url: "https://avatars.githubusercontent.com/u/1410106?v=4",
      bio: nil,
      blog: "http://anto.sh",
      company: nil,
      created_at: "2012-02-05T14:53:26Z",
      email: nil,
      events_url: "https://api.github.com/users/A/events{/privacy}",
      followers: 529,
      followers_url: "https://api.github.com/users/A/followers",
      following: 149,
      following_url: "https://api.github.com/users/A/following{/other_user}",
      gists_url: "https://api.github.com/users/A/gists{/gist_id}",
      gravatar_id: "",
      hireable: nil,
      html_url: "https://github.com/A",
      id: 1_410_106,
      location: "Ho Chi Minh, Vietnam",
      login: "A",
      name: "Shuvalov Anton",
      node_id: "MDQ6VXNlcjE0MTAxMDY=",
      organizations_url: "https://api.github.com/users/A/orgs",
      public_gists: 128,
      public_repos: 26,
      received_events_url: "https://api.github.com/users/A/received_events",
      repos_url: "https://api.github.com/users/A/repos",
      site_admin: false,
      starred_url: "https://api.github.com/users/A/starred{/owner}{/repo}",
      subscriptions_url: "https://api.github.com/users/A/subscriptions",
      twitter_username: nil,
      type: "User",
      updated_at: "2022-12-09T11:12:18Z",
      url: "https://api.github.com/users/A"
    }

    Mox.stub(GithubSearch.Helper.ClientMock, :http_get_profile, fn _url ->
      {:ok,
       %HTTPoison.Response{
         body:
           "{\"login\":\"A\",\"id\":1410106,\"node_id\":\"MDQ6VXNlcjE0MTAxMDY=\",\"avatar_url\":\"https://avatars.githubusercontent.com/u/1410106?v=4\",\"gravatar_id\":\"\",\"url\":\"https://api.github.com/users/A\",\"html_url\":\"https://github.com/A\",\"followers_url\":\"https://api.github.com/users/A/followers\",\"following_url\":\"https://api.github.com/users/A/following{/other_user}\",\"gists_url\":\"https://api.github.com/users/A/gists{/gist_id}\",\"starred_url\":\"https://api.github.com/users/A/starred{/owner}{/repo}\",\"subscriptions_url\":\"https://api.github.com/users/A/subscriptions\",\"organizations_url\":\"https://api.github.com/users/A/orgs\",\"repos_url\":\"https://api.github.com/users/A/repos\",\"events_url\":\"https://api.github.com/users/A/events{/privacy}\",\"received_events_url\":\"https://api.github.com/users/A/received_events\",\"type\":\"User\",\"site_admin\":false,\"name\":\"Shuvalov Anton\",\"company\":null,\"blog\":\"http://anto.sh\",\"location\":\"Ho Chi Minh, Vietnam\",\"email\":null,\"hireable\":null,\"bio\":null,\"twitter_username\":null,\"public_repos\":26,\"public_gists\":128,\"followers\":529,\"following\":149,\"created_at\":\"2012-02-05T14:53:26Z\",\"updated_at\":\"2022-12-09T11:12:18Z\"}",
         headers: [
           {"Server", "GitHub.com"},
           {"Date", "Wed, 25 Jan 2023 07:54:15 GMT"},
           {"Content-Type", "application/json; charset=utf-8"},
           {"Cache-Control", "public, max-age=60, s-maxage=60"},
           {"Vary", "Accept, Accept-Encoding, Accept, X-Requested-With"},
           {"ETag", "W/\"8db3f005024ac0f445ff180ecf32397a71a10f551d5594ee2277ddb97eb3afc3\""},
           {"Last-Modified", "Fri, 09 Dec 2022 11:12:18 GMT"},
           {"X-GitHub-Media-Type", "github.v3; format=json"},
           {"x-github-api-version-selected", "2022-11-28"},
           {"Access-Control-Expose-Headers",
            "ETag, Link, Location, Retry-After, X-GitHub-OTP, X-RateLimit-Limit, X-RateLimit-Remaining, X-RateLimit-Used, X-RateLimit-Resource, X-RateLimit-Reset, X-OAuth-Scopes, X-Accepted-OAuth-Scopes, X-Poll-Interval, X-GitHub-Media-Type, X-GitHub-SSO, X-GitHub-Request-Id, Deprecation, Sunset"},
           {"Access-Control-Allow-Origin", "*"},
           {"Strict-Transport-Security", "max-age=31536000; includeSubdomains; preload"},
           {"X-Frame-Options", "deny"},
           {"X-Content-Type-Options", "nosniff"},
           {"X-XSS-Protection", "0"},
           {"Referrer-Policy", "origin-when-cross-origin, strict-origin-when-cross-origin"},
           {"Content-Security-Policy", "default-src 'none'"},
           {"X-RateLimit-Limit", "60"},
           {"X-RateLimit-Remaining", "52"},
           {"X-RateLimit-Reset", "1674635157"},
           {"X-RateLimit-Resource", "core"},
           {"X-RateLimit-Used", "8"},
           {"Accept-Ranges", "bytes"},
           {"Content-Length", "1123"},
           {"X-GitHub-Request-Id", "8FEC:1098:3188:3932:63D0E027"}
         ],
         request: %HTTPoison.Request{
           body: "",
           headers: [],
           method: :get,
           options: [],
           params: %{},
           url: "https://api.github.com/users/a"
         },
         request_url: "https://api.github.com/users/a",
         status_code: 200
       }}
    end)

    assert profile("a") == api_response
  end
end
