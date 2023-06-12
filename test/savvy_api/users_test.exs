defmodule SavvyApi.UsersTest do
  use ExUnit.Case, async: false
  use SavvyApi.DataCase
  alias SavvyApi.Users.User
  alias SavvyApi.Users
  alias SavvyApi.Repo

  @valid_attrs %{points: 50}
  @invalid_attrs %{points: "string"}
  @min_num 35

  def user_fixture() do
    Users.create_user(%{points: Enum.random(1..100)})
  end

  describe "create_user/1" do
    test "success: it inserts a user in the db and returns the user" do
      assert {:ok, %User{} = returned_user} = Users.create_user(@valid_attrs)

      user_from_db = Repo.get(User, returned_user.id)
      assert returned_user == user_from_db
    end

    test "error: returns an error tuple when user can't be created" do
      assert {:error, %Ecto.Changeset{valid?: false}} = Users.create_user(@invalid_attrs)
    end

    test "error: returns an error tuple when user points is given num outside of range" do
      assert {:error, %Ecto.Changeset{valid?: false}} = Users.create_user(%{points: 201})
      assert {:error, %Ecto.Changeset{valid?: false}} = Users.create_user(%{points: -7})
    end
  end

  describe "get_users/1" do
    test "success: with minimum number - returns two users from db above min num" do
      users = [
        %SavvyApi.Users.User{
          points: 24
        },
        %SavvyApi.Users.User{
          points: 79
        },
        %SavvyApi.Users.User{
          points: 64
        }
      ]

      Enum.each(users, fn u -> Repo.insert(u) end)
      
      assert Users.get_users(@min_num) == [%{points: 79}, %{points: 64}]
    end

    test "success: with minimum number - returns one user from db above min num" do
      users = [
        %SavvyApi.Users.User{
          points: 24
        },
        %SavvyApi.Users.User{
          points: 79
        },
        %SavvyApi.Users.User{
          points: 22
        }
      ]

      Enum.each(users, fn u -> Repo.insert(u) end)
      assert Users.get_users(@min_num) == [%{points: 79}]
    end

    test "success: with minimum number - returns empty array when no users in db have points above minimum number" do
      users = [
        %SavvyApi.Users.User{
          points: 24
        },
        %SavvyApi.Users.User{
          points: 18
        },
        %SavvyApi.Users.User{
          points: 22
        }
      ]

      Enum.each(users, fn u -> Repo.insert(u) end)
      assert Users.get_users(@min_num) == []
    end
  end

  # describe "update_users/0" do
  #   setup _ do
  #     1..10 |> Enum.each(fn _ -> user_fixture() end)
  #   end

  #   test "success: it updates all users in the db" do
  #     before_update = Repo.all(User)

  #     {num_of_items_updated, nil} = Users.update_users()

  #     after_update = Repo.all(User)

  #     assert before_update != after_update
  #     assert num_of_items_updated == length(before_update)
  #     assert Enum.map(before_update, fn i -> i.id end) == Enum.map(after_update, fn i -> i.id end)
  #   end
  # end
end
