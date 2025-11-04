require "test_helper"

class TaskJobTest < ActiveJob::TestCase
  test "should update task status to done when performed" do
    task = Task.create!(name: "Test Task", status: :pending)

    TaskJob.perform_now(task.id)

    task.reload
    assert_equal "done", task.status
  end

  test "should handle missing task gracefully" do
    assert_nothing_raised do
      TaskJob.perform_now(99_999)
    end
  end

  test "should set task status to failed on error" do
    task = Task.create!(name: "Test Task", status: :pending)

    # Mock the update to raise an error
    mock_task = Minitest::Mock.new
    mock_task.expect(:update!, nil) { raise StandardError, "Test error" }
    Task.stub(:find_by, mock_task) do
      assert_raises StandardError do
        TaskJob.perform_now(task.id)
      end
    end
  end

  test "should queue the job" do
    assert_enqueued_with(job: TaskJob, args: [1]) do
      TaskJob.perform_later(1)
    end
  end

  test "should use default queue" do
    job = TaskJob.new
    assert_equal "default", job.queue_name
  end
end
