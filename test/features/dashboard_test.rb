$LOAD_PATH.unshift(File.expand_path("../..", __FILE__))
require "test_helper"

feature "Dashboard Feature Test" do
  scenario "Normal user with projects" do
    dashboard = DashboardPage.new
    user_factory = UserFactory.new
    project_factory = ProjectFactory.new
    task_factory = TaskFactory.new

    user = user_factory.create
    project_a = project_factory.create(:user => user)
      task_factory.create(:project => project_a, :started_at => Time.zone.now)
    project_b = project_factory.create(:user => user)
      task_factory.create(:project => project_b, :started_at => Time.zone.now)

    SigninPage.new(user).signin_user

    dashboard.has_project_breakdown? 
    dashboard.project_breakdown_rows.size.must_equal 3
  end

  scenario "Normal user with no projects" do
    dashboard = DashboardPage.new
    user_factory = UserFactory.new

    user = user_factory.create

    SigninPage.new(user).signin_user

    dashboard.has_project_breakdown? 
    dashboard.project_breakdown_rows.size.must_equal 1
  end

  scenario "Admin user with multiple users with projects" do
  end
end
