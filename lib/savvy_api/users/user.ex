defmodule SavvyApi.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :points, :integer, default: 0

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:points])
    |> validate_required([:points])
    |> validate_number(:points, greater_than_or_equal_to: 0, less_than: 101)
    # |> check_constraint(:points, name: :points_range, message: "Points range constraint: points are outside of range")
  end
end
