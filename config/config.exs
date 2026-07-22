# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :skeleton_key,
  ecto_repos: [SkeletonKey.Repo],
  generators: [timestamp_type: :utc_datetime, binary_id: true]

# Configures the endpoint
config :skeleton_key, SkeletonKeyWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: SkeletonKeyWeb.ErrorHTML, json: SkeletonKeyWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: SkeletonKey.PubSub,
  live_view: [signing_salt: "IXFbucjC"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :skeleton_key, SkeletonKey.Mailer,
  adapter: Swoosh.Adapters.Logger,
  level: :warning,
  log_full_email: true,
  sender_email: "noreply_dev@skeleton_key.com"

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.25.4",
  skeleton_key: [
    args:
      ~w(js/app.js --bundle --target=es2022 --outdir=../priv/static/assets/js --external:/fonts/* --external:/images/* --alias:@=.),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => [Path.expand("../deps", __DIR__), Mix.Project.build_path()]}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "4.1.12",
  skeleton_key: [
    args: ~w(
      --input=css/app.css
      --output=../priv/static/assets/css/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
