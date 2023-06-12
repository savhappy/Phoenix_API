defmodule SavvyApiWeb.UsersControllerTest do
  use SavvyApiWeb.ConnCase, async: false
  alias SavvyApiWeb.UsersController
  alias SavvyApi.Users

  def user_fixture() do
    Users.create_user(%{points: Enum.random(1..100)})
  end

  setup _ do
    1..10 |> Enum.each(fn _ -> user_fixture() end)
  end

  describe "GET / index/2" do
    test "success: updates state returns status 200 with users data", %{conn: conn} do
      conn =
        conn
        |> get(~p"/")

      find_users = UsersController.format_users(conn.assigns.min_number)

      assert conn.status == 200
      assert conn.assigns.users == find_users
    end
  end
end
