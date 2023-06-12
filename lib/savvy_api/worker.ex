defmodule SavvyApi.Worker do
  use GenServer
  alias SavvyApi.Users

  @interval 60000

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    Process.send_after(self(), :poll_users, @interval)
    {:ok, %{}, {:continue, :load_data}}
  end

  def handle_continue(:load_data, _state) do
    state = %{
      min_number: calc_random_num(),
      timestamp: nil
    }

    {:noreply, state}
  end

  def handle_info(:poll_users, state) do
    state = %{state | min_number: calc_random_num()}
    Task.start_link(fn -> Users.update_users() end)
    Process.send_after(self(), :poll_users, @interval)
    {:noreply, state}
  end

  def get(server, :get_users) do
    GenServer.call(server, :get_users)
  end

  def handle_call(:get_users, _from, state) do
    timestamp = Map.get(state, :timestamp)
    state = %{state | timestamp: time_helper()}
    {:reply, {timestamp, state.min_number}, state}
  end

  defp calc_random_num, do: Enum.random(0..100)

  defp time_helper() do
    :erlang.universaltime()
    |> :erlang.universaltime_to_localtime()
    |> NaiveDateTime.from_erl!()
    |> Calendar.strftime("%y-%m-%d %I:%M:%S %p")
  end
end
