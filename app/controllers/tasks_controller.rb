class TasksController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def index
    @tasks = Task.recent
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to tasks_path, notice: "Task created and job enqueued!" }
      end
    end
  end

  private

  def task_params
    params.require(:task).permit(:name)
  end

  def render_not_found
    render plain: "Not Found", status: :not_found
  end
end
