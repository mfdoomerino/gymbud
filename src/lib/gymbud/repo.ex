defmodule Gymbud.Repo do
  use Ecto.Repo,
    otp_app: :gymbud,
    adapter: Ecto.Adapters.Postgres
end
