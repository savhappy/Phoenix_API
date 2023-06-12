defmodule SavvyApi.WorkerTest do
  use ExUnit.Case
  use SavvyApi.DataCase
  alias SavvyApi.Worker
  alias SavvyApi.Users

  describe "handle_continue/2" do
    test "success: sets up current state" do
      assert {:noreply, state} = Worker.handle_continue(:load_data, [])

      assert state.timestamp == nil
      assert is_integer(state.min_number) == true
    end
  end

  describe "handle_info/2" do
    test "success: sets up current state" do
      state = %{timestamp: nil, min_number: Enum.random(1..100)}

      assert {:noreply, state} = Worker.handle_info(:poll_users, state)

      assert state.timestamp == nil
      assert is_integer(state.min_number) == true
    end
  end

  describe "get/2" do
    def user_fixture() do
      Users.create_user(%{points: Enum.random(1..100)})
    end

    setup _ do
      1..10 |> Enum.each(fn _ -> user_fixture() end)
    end

    test "success: shows that timestamp state is updated between calls" do
      {call_one, _min_num} = Worker.get(SavvyApi.Worker, :get_users)
      {call_two, _min_num} = Worker.get(SavvyApi.Worker, :get_users)

      assert call_one == nil,
             "Timestamp displays nil on first call"

      assert call_two != nil,
             "Timestamp displays previous query timestamp #{call_two} on first call"
    end
  end
end
