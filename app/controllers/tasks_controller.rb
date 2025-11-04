class TasksController < ApplicationController
  def index
    @tasks = Task.all.order(created_at: :desc)
    @task = Task.new
  end

  def create
    @task = Task.new(name: params[:name], status: "pending")
    if @task.name.blank?
      @tasks = Task.all.order(created_at: :desc)
      flash.now[:alert] = "Task name can't be blank."
      render :index, status: :unprocessable_entity
    else
      @task.save!
      TaskJob.perform_later(@task.id)
      redirect_to tasks_path, notice: "Task created and job enqueued!"
    end
  end
end