class TaskJob < ApplicationJob
  queue_as :default

  retry_on StandardError, wait: 5.seconds, attempts: 3

  def perform(task_id)
    task = Task.find_by(id: task_id)
    return unless task

    # Simulate work
    sleep 2

    task.update!(status: :done)
    task.broadcast_replace_to "tasks"
  rescue StandardError => e
    task.update!(status: :failed) if task
    task.broadcast_replace_to "tasks" if task
    raise e
  end
end
