defmodule SavvyApi.Repo do
  use Ecto.Repo,
    otp_app: :savvy_api,
    adapter: Ecto.Adapters.Postgres
end
