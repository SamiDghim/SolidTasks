class TaskJob < ApplicationJob
  queue_as :default

  def perform(task_id)
    task = Task.find_by(id: task_id)
    return unless task

    sleep 2
    task.update!(status: "done")
  end
end
