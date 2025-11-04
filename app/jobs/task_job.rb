class TaskJob < ApplicationJob
  queue_as :default

  #
  retry_on StandardError, wait: 5.seconds, attempts: 3

  def perform(task_id)
    task = Task.find_by(id: task_id)
    return unless task
    sleep 2
    task.update!(status: :done)
  end
end
