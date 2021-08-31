defmodule WorkflowExample.Second do
  use Oban.Pro.Workers.Workflow, max_attempts: 1

  @impl true
  def process(%Job{args: %{"val" => return_value}} = job) do
    {String.to_atom(return_value), return_value}
  end
end
