defmodule WorkflowExample.Repo do
  use Ecto.Repo,
    otp_app: :workflow_example,
    adapter: Ecto.Adapters.Postgres
end
