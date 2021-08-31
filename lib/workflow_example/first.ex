defmodule WorkflowExample.First do
  use Oban.Pro.Workers.Workflow, max_attempts: 1

  alias WorkflowExample.{First, Second, Third}

  def go(second_value) do
    new_workflow(waiting_limit: 40, waiting_delay: 10, waiting_snooze: 1)
    |> add(:first, First.new(%{}))
    |> add(:second, Second.new(%{val: second_value}), deps: [:first])
    |> Oban.insert_all()
  end

  @impl true
  def process(%Job{meta: %{"workflow_id" => workflow_id}} = job) do
    Third.new(%{}, meta: %{"workflow_id" => workflow_id, "name" => "third", "deps" => ["second"]})
    |> Oban.insert!()

    :ok
  end
end
