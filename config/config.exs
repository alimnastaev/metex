# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :metex,
  ecto_repos: [Metex.Repo]

# Configures the endpoint
config :metex, MetexWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "fU1FK42ZirK5pKZKT+bVWcyEK8VNx0ztf7sWm8Av4qWP0ZhNji+NFHrasQvXSlCM",
  render_errors: [view: MetexWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Metex.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

import_config "#{Mix.env}.secret.exs"
