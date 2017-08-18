# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :api,
  ecto_repos: [Api.Repo]

# Configures the endpoint
config :api, ApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "J5u3lcy5VkvYgZgDwGSN0ueoIWqF+BsQ2yU5dwHhS5Ev3w0AXNazk/mIdK7P5huJ",
  render_errors: [view: ApiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Api.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :guardian, Guardian,
  allowed_algos: ["HS512"], # optional - The list of algorithms (must be compatible with JOSE). The first is used as the encoding key. Default is: ["HS512"]
  verify_module: Guardian.JWT,  # optional - Provides a mechanism to setup your own validations for items in the token. Default is Guardian.JWT
  issuer: "Api", # The entry to put into the token as the issuer. This can be used in conjunction with verify_issuer
  ttl: { 30, :days }, # The default ttl of a token
  verify_issuer: true, # optional - If set to true, the issuer will be verified to be the same issuer as specified in the issuer field
  secret_key: "J5u3lcy5VkvYgZgDwGSN0ueoIWqF+BsQ2yU5dwHhS5Ev3w0AXNazk/mIdK7P5huJ", # The key to sign the tokens
  serializer: Api.GuardianSerializer # The serializer that serializes the 'sub' (Subject) field into and out of the token

config :mime, :types, %{"application/json; charset=utf-8" => ["json"]}

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
