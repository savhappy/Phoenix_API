defmodule SavvyApiWeb.UsersJSON do
  def index(%{timestamp: timestamp, users: users}) do
    %{users: users, timestamp: timestamp}
  end
end
