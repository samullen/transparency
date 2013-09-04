class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def show
    now = Time.zone.now
    @daterange = Daterange.new(now.beginning_of_month, now.end_of_month)

    projects = Project.accessible_by(current_user).active_for_daterange(@daterange)
    prepare_dashboard(projects, @daterange)
  end

  def create
    month = Time.parse(params[:month])

    @daterange = Daterange.new(month.beginning_of_month, month.end_of_month)

    projects = Project.accessible_by(current_user).active_for_daterange(@daterange)
    prepare_dashboard(projects, @daterange)

    render :show
  end

  private

  def prepare_dashboard(projects, daterange)
    @project_windows = ProjectWindow.for_projects(projects, daterange)
    @project_analytic = ProjectAnalytic.new(@project_windows)

    @months = TaskQuery.new.range_of_months(projects)
  end
end
