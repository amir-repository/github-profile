defmodule GithubSearchWeb.GithubSearchLive do
  use GithubSearchWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>Hey</h1>
    """
  end
end
