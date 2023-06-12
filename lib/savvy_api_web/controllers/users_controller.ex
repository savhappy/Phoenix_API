defmodule SavvyApiWeb.UsersController do
  use SavvyApiWeb, :controller
  alias SavvyApi.Worker
  alias SavvyApi.Users

  def index(conn, _params) do
    with {timestamp, min_number} <- Worker.get(SavvyApi.Worker, :get_users) do
      render(conn, :index,
        timestamp: timestamp,
        users: format_users(min_number),
        min_number: min_number
      )
    end
  end

  def format_users(min_num) do
    Users.get_users(min_num)
    |> Enum.map(fn x -> %{id: x.id, points: x.points} end)
  end
end
