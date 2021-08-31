defmodule WorkflowExampleTest do
  use WorkflowExample.DataCase, async: true
  use Oban.Testing, repo: WorkflowExample.Repo

  alias WorkflowExample.{First, Second, Third}

  describe "go" do
    test "enqueues a second worker" do
      First.go("ok")

      assert_enqueued(worker: First, args: %{})
      assert_enqueued(worker: Second, args: %{val: "ok"})
    end

    test "runs all three workers" do
      First.go("ok")

      assert %{success: 3, failure: 0} =
               Oban.drain_queue(
                 queue: :default,
                 with_recursion: true,
                 with_scheduled: true,
                 with_safety: false
               )
    end

    test "cancels the workflow if second errors" do
      First.go("error")

      assert %{success: 1, failure: 1} =
               Oban.drain_queue(
                 queue: :default,
                 with_recursion: true,
                 with_scheduled: true,
                 with_safety: false
               )
    end
  end
end
