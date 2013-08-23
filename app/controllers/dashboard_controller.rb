class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def show
    @project_windows = ProjectWindow.for_projects(current_user.projects)
    @project_analytic = ProjectAnalytic.new(@project_windows)
  end
end
