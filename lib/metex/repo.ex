defmodule Metex.Repo do
  use Ecto.Repo,
    otp_app: :metex,
    adapter: Ecto.Adapters.Postgres
end
