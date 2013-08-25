$LOAD_PATH.unshift(File.expand_path("../..", __FILE__))
require "test_helper"

describe "POST :: /api/projects request" do
  describe "Creating a new project" do
    it "creates and returns the new project" do
      user_factory = UserFactory.new
      admin = user_factory.create(:role => 'admin')
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
    it "returns the existing project" do
      user_factory = UserFactory.new
      admin = user_factory.create(:role => 'admin')
      user = user_factory.create({:remote_id => 42})
      project = Project.create(:name => "Example Project", :remote_id => 1001, :user_id => user.id)

      post api_projects_path(:json, {
        :auth_token => admin.authentication_token,
        :name => project.name,
        :remote_client_id => 42,
        :remote_project_id => 1001
      })

      json_response = JSON.parse(response.body)

      json_response["id"].must_equal project.id
      json_response["name"].must_equal project.name
      json_response["remote_id"].must_equal project.remote_id.to_s
    end
  end

  describe "non admin access to projects" do
    it "returns an 'unauthorized' error" do
      user_factory = UserFactory.new
      user = user_factory.create({:remote_id => 42})

      post api_projects_path(:json, {
        :auth_token => user.authentication_token,
        :name => "Example project",
        :remote_client_id => 42,
        :remote_project_id => 1001
      })

      json_response = JSON.parse(response.body)

      json_response["error"].must_equal "unauthorized access"
      json_response.keys.size.must_equal 1
    end
  end
end
