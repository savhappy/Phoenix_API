defmodule SavvyApi.Users do
  import Ecto.Query, warn: false
  alias SavvyApi.Repo
  alias SavvyApi.Users.User

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_users() do
    User
    |> update(set: [points: fragment("floor(random()*100)")])
    |> Repo.update_all([])
  end

  def get_users(min_num) do
    Repo.all(
      from(u in User,
        where: u.points > ^min_num,
        select: %{id: u.id, points: u.points},
        limit: 2
      )
    )
  end
end
