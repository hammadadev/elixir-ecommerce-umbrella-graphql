# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of the Config module.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
import Config

# Configure Mix tasks and generators
config :ecommerce,
  ecto_repos: [Ecommerce.Repo]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :ecommerce, Ecommerce.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

config :ecommerce_web,
  ecto_repos: [Ecommerce.Repo],
  generators: [context_app: :ecommerce]

# Configures the endpoint
config :ecommerce_web, EcommerceWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: EcommerceWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Ecommerce.PubSub,
  live_view: [signing_salt: "2PbwSP3G"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.29",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../apps/ecommerce_web/assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :ecommerce, Ecommerce.Guardian,
  issuer: "ecommerce",
  allowed_algos: ["HS512"],
  ttl: {1, :week},
  secret_key: "ZT792Egkt48wIlL+twT3+H8lIXjVFgZeHQ0N5uLphGr/QEOfDb/ie6xj4EhNYeHY"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
