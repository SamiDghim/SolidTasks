class Task < ApplicationRecord
  enum :status, { pending: "pending", done: "done", failed: "failed" }, default: :pending

  validates :name, presence: true, length: { minimum: 1, maximum: 255 }

  scope :recent, -> { order(created_at: :desc) }
  scope :by_status, ->(status) { where(status: status) if status.present? }

  broadcasts_to ->(task) { "tasks" }, inserts_by: :prepend, partial: "tasks/task"

  after_create_commit { TaskJob.perform_later(id) }
end
