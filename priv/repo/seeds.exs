alias SavvyApi.Users.User

now = DateTime.utc_now() |> DateTime.to_naive() |> NaiveDateTime.truncate(:second)

1..1_000_000
|> Enum.map(fn _ -> %{points: 0, inserted_at: now, updated_at: now} end)
|> Enum.chunk_every(70000)
|> Enum.each(fn x ->
  Ecto.Multi.new()
  |> Ecto.Multi.insert_all(:insert_all, User, x)
  |> SavvyApi.Repo.transaction()
end)
