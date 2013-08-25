$LOAD_PATH.unshift(File.expand_path("../..", __FILE__))
require "test_helper"

describe "POST :: /api/projects request" do
  describe "Creating a new project" do
    it "creates and returns the new project" do
      user_factory = UserFactory.new
      admin = user_factory.create
      user = user_factory.create({:remote_id => 42})

      post api_projects_path(:json, {
        :auth_token => admin.authentication_token,
        :name => "Example Project",
        :remote_client_id => 42,
        :remote_project_id => 1001
      })

      json_response = JSON.parse(response.body)

      json_response["id"].must_be :present?
      json_response["name"].must_equal "Example Project"
      json_response["remote_id"].must_equal "1001"
    end
  end

  describe "A project already exists" do
  end
end
