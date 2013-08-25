$LOAD_PATH.unshift(File.expand_path("../..", __FILE__))
require "test_helper"

describe "POST :: /api/tasks request" do
  describe "Creating a new task" do
    it "creates and returns the new task" do
      admin = UserFactory.new.create(:role => 'admin')
      project = ProjectFactory.new.create

      post api_tasks_path(:json, {
        :auth_token => admin.authentication_token,
        :name => "Example Task",
        :remote_task_id => 42,
        :remote_project_id => 1001,
        :category_name => "Example Category",
        :billable => true,
        :hours => 10,
        :started_at => 10.days.ago
      })

      json_response = JSON.parse(response.body)

      json_response["id"].must_be :present?
      json_response["name"].must_equal "Example Task"
      json_response["remote_id"].must_equal 42
    end
  end
end
