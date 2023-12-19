import Config

config :example, Example.Repo,
  database: "postgres",
  username: "postgres",
  password: "postgres",
  hostname: "postgres"

config :example, cowboy_port: 8080
config :example, ecto_repos: [Example.Repo]
