require "test_helper"

class TaskTest < ActiveSupport::TestCase
  test "should be valid with valid attributes" do
    task = Task.new(name: "Test Task")
    assert task.valid?
  end

  test "should not be valid without name" do
    task = Task.new(name: nil)
    assert_not task.valid?
    assert task.errors[:name].present?
  end

  test "should not be valid with blank name" do
    task = Task.new(name: "")
    assert_not task.valid?
    assert task.errors[:name].present?
  end

  test "should not be valid with name longer than 255 characters" do
    task = Task.new(name: "a" * 256)
    assert_not task.valid?
    assert task.errors[:name].present?
  end

  test "status should default to pending" do
    task = Task.create!(name: "Test Task")
    assert_equal "pending", task.status
  end

  test "should have pending status enum" do
    assert_equal "pending", Task.statuses[:pending]
  end

  test "should have done status enum" do
    assert_equal "done", Task.statuses[:done]
  end

  test "should have failed status enum" do
    assert_equal "failed", Task.statuses[:failed]
  end
end
