import Config

config :workflow_example, WorkflowExample.Repo,
  database: "workflow_example",
  username: "postgres",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :workflow_example, ecto_repos: [WorkflowExample.Repo]

config :workflow_example, Oban, queues: false, plugins: false, repo: WorkflowExample.Repo
