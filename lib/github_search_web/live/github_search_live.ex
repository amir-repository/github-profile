defmodule GithubSearchWeb.GithubSearchLive do
  use GithubSearchWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok,
     assign(socket, :user, %{
       name: nil,
       username: nil,
       avatar_url: nil,
       created_at: nil,
       bio: nil,
       public_repos: nil,
       followers: nil,
       following: nil,
       location: nil,
       blog: nil,
       twitter_username: nil,
       github: nil
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
