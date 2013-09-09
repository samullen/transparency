class ProjectsController < ApplicationController
  before_filter :authenticate_user!

  def show
    @month = params[:month] ? Date.parse(params[:month]) : Date.today
    prepare_project_page
  end

  def create
    @month = Date.parse(params[:month])
    prepare_project_page

    render :show
  end

  private

  def prepare_project_page
    @daterange = Daterange.new(@month.beginning_of_month, @month.end_of_month)

    @project = Project.accessible_by(current_user).active_for_daterange(@daterange).find(params[:id] || params[:project_id])
    @project_window = ProjectWindow.new(@project, @daterange)
    @months = TaskQuery.new.range_of_months([@project])
  end
end
