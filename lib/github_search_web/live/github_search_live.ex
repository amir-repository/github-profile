defmodule GithubSearchWeb.GithubSearchLive do
  use GithubSearchWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :username, "Derek")}
  end

  def handle_event("search_username", %{"username" => username}, socket) do
    {:noreply, assign(socket, :username, username)}
  end
end
