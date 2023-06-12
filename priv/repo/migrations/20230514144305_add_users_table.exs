defmodule SavvyApi.Repo.Migrations.AddUsersTable do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :points, :integer

      timestamps()
    end

    # create constraint(:users, :points_range, check: "points >= 0 and points <= 100")
  end
end
