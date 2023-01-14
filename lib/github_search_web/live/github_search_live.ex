defmodule GithubSearchWeb.GithubSearchLive do
  use GithubSearchWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok,
     assign(socket, :user, %{
       name: "name",
       username: "username",
       avatar_url: "",
       created_at: "",
       bio: "bio",
       public_repos: 0,
       followers: 0,
       following: 0,
       location: "",
       blog: "",
       twitter: "",
       github: ""
     })}
  end

  def handle_event("search_username", %{"username" => username}, socket) do
    user = user_search(username)
    user = Map.put(user, :username, username)
    IO.inspect(user)
    {:noreply, assign(socket, :user, user)}
  end

  defp user_search(username) do
    api_url = "https://api.github.com/users/"
    {:ok, result} = HTTPoison.get(api_url <> username)
    decode_json(result.body)
  end

  defp decode_json(json) do
    {:ok, result} = Jason.decode(json, keys: :atoms)
    result
  end
end
