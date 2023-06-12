## SavvyApi

# Hello! Welcome to my tiny Phoenix Application

The intended functionality of this app is to return, at max 2 users, and a timestamp. The users returned will have points that are above whatever minimum number has been set by the genserver. The timestamp is initially set to null but after the first query will return the previous queries timestamp. Enjoy!



To start your Phoenix server:

  * Run `mix deps.get` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

To seed your application:
  * Run `mix ecto.setup` to populate 1,000,000 users to db

Now you can visit [`localhost:4000`](http://localhost:4000) from your browserI