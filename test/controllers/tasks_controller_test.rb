require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tasks_url
    assert_response :success
  end

  test "should display all tasks on index" do
    task1 = Task.create!(name: "Task 1")
    task2 = Task.create!(name: "Task 2")

    get tasks_url
    assert_response :success
    assert_select "table" do
      assert_select "tr", count: 3 # header + 2 tasks
    end
  end

  test "should create task with valid parameters" do
    assert_difference("Task.count", 1) do
      post tasks_url, params: { task: { name: "New Task" } }
    end

    assert_redirected_to tasks_url
    assert_equal "Task created and job enqueued!", flash[:notice]
  end

  test "should enqueue job when task is created" do
    assert_enqueued_with(job: TaskJob) do
      post tasks_url, params: { task: { name: "New Task" } }
    end
  end

  test "should not create task with blank name" do
    assert_no_difference("Task.count") do
      post tasks_url, params: { task: { name: "" }, format: :turbo_stream }
    end

    assert_response :unprocessable_entity
  end

  test "should not create task with nil name" do
    assert_no_difference("Task.count") do
      post tasks_url, params: { task: { name: nil }, format: :turbo_stream }
    end

    assert_response :unprocessable_entity
  end

  test "should display new task form on index" do
    get tasks_url
    assert_response :success
    assert_select "form[action='#{tasks_path}']"
  end

  test "should reject unpermitted parameters" do
    post tasks_url, params: { task: { name: "Task", status: "done", unknown: "param" } }
    task = Task.last
    assert_equal "pending", task.status
  end

  test "should respond with turbo_stream on create" do
    post tasks_url, params: { task: { name: "New Task" }, format: :turbo_stream }
    assert_response :success
  end
end
