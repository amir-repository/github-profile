defmodule GithubSearchWeb.HelperTest do
  use ExUnit.Case, async: true
  # 1. Import Mox
  import Mox
  # 2. setup fixtures
  setup :verify_on_exit!

  # test ":ok on 200" do
  #   expect(HTTPoison.BaseMock, :get, fn _ -> {:ok, "What a guy!"} end)

  #   assert {:ok, _} = MyModule.get_username("twinkie")
  # end
end
