$LOAD_PATH.unshift(File.expand_path("../..", __FILE__))
require "test_helper"

describe "POST :: /api/tasks request" do
  describe "Creating a new task" do
    it "creates and returns the new task" do
      admin = UserFactory.new.create(:role => 'admin')
      project = ProjectFactory.new.create(:user_id => 1001, :remote_id => 1001)

      post api_foreign_tasks_path(:json, {
        :auth_token => admin.authentication_token,
        :remote_project_id => 1001,
        :name => "Example Task",
        :remote_task_id => 42,
        :category_name => "Example Category",
        :billable => true,
        :hours => 10,
        :started_at => 10.days.ago
      })

      json_response = JSON.parse(response.body)

      json_response["id"].must_be :present?
      json_response["name"].must_equal "Example Task"
      json_response["remote_id"].must_equal "42"
    end
  end

  describe "A task already exists" do
    it "creates and returns the new task" do
      admin = UserFactory.new.create(:role => 'admin')
      project = ProjectFactory.new.create(:user_id => 1001, :remote_id => 1001)
      task = Task.create(:project => project, :name => "Example Task", :remote_id => 42, :billable => true, :hours => 10, :started_at => 10.days.ago)

      post api_foreign_tasks_path(:json, {
        :auth_token => admin.authentication_token,
        :remote_project_id => 1001,
        :name => "Example Task",
        :remote_task_id => 42,
        :category_name => "Example Category",
        :billable => true,
        :hours => 10,
        :started_at => 10.days.ago
      })

      json_response = JSON.parse(response.body)

      json_response["id"].must_equal task.id
      json_response["name"].must_equal "Example Task"
      json_response["remote_id"].must_equal "42"
    end
  end

  describe "non admin access to tasks" do
    it "returns an 'unauthorized' error" do
      user_factory = UserFactory.new
      user = user_factory.create({:remote_id => 42})

      post api_foreign_tasks_path(:json, {
        :auth_token => user.authentication_token,
        :name => "Example project",
        :remote_project_id => 42,
        :remote_task_id => 1001
      })

      json_response = JSON.parse(response.body)

      json_response["error"].must_equal "unauthorized access"
      json_response.keys.size.must_equal 1
    end
  end
end
