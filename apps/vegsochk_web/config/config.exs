# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :vegsochk_web,
  namespace: VegsochkWeb,
  ecto_repos: [Vegsochk.Repo]

# Configures the endpoint
config :vegsochk_web, VegsochkWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "kDWv9eH5gbErYsGRL33DzjZT6wK6V/vMmKl9WL/huI7XbzDPc/+umNDYk5FdTjoz",
  render_errors: [view: VegsochkWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: VegsochkWeb.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :vegsochk_web, :generators,
  context_app: :vegsochk

# Configure :ex_aws
  
config :ex_aws,
  access_key_id: [{:system, "AWS_ACCESS_KEY_ID"}, :instance_role],
  secret_access_key: [{:system, "AWS_SECRET_ACCESS_KEY"}, :instance_role],
  region: "ap-southeast-1"
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
