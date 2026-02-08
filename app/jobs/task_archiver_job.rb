class TaskArchiverJob < ApplicationJob
  queue_as :default

  def perform
    Rails.logger.info "Archiving done tasks..."
    Task.archivable.update_all(status: :archived)
  end
end
