class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def show
    projects = Project.accessible_by(current_user)
    @project_windows = ProjectWindow.for_projects(projects)
    @project_analytic = ProjectAnalytic.new(@project_windows)
  end
end
