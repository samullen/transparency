$LOAD_PATH.unshift(File.expand_path("../..", __FILE__))
require "test_helper"

feature "Project page Feature Test" do
  scenario "Normal user with project tasks" do
    project_page = ProjectPage.new
    user_factory = UserFactory.new
    project_factory = ProjectFactory.new
    task_factory = TaskFactory.new

    user = user_factory.create
    project = project_factory.create(:user => user)
      task_factory.create(:project => project, :started_at => Time.zone.now)

    SigninPage.new(user).signin_user

    visit praject_path(project)

    project_page.has_task_breakdown? 
    project_page.task_breakdown_rows.size.must_equal 2
  end
end
