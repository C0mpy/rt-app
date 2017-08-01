export DB_URL="ecto://postgres:postgres@localhost/postgres"
mix ecto.create
mix ecto.migrate
make console CMD=./priv/repo/seed.exs
make console CMD=mix test
yes | mix ecto.drop
