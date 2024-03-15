# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :deck_n_dice,
  ecto_repos: [DeckNDice.Repo],
  generators: [timestamp_type: :utc_datetime, binary_id: true]

# Configures the endpoint
config :deck_n_dice, DeckNDiceWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [json: DeckNDiceWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: DeckNDice.PubSub,
  live_view: [signing_salt: "2JLu6riH"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Configures the guardian
config :deck_n_dice, DeckNDiceWeb.Auth.Guardian,
  issuer: "deck_n_dice",
  secret_key: "C78p0kcMkO9H3omUJSDWME28jXaYYpI2+utsUfosDr2aEWJ7rfyM9B1K35srcJXY"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
