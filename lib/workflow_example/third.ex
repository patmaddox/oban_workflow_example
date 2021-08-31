defmodule WorkflowExample.Third do
  use Oban.Pro.Workers.Workflow, max_attempts: 1

  @impl true
  def process(%Job{} = job) do
    :ok
  end
end
