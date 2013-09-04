class Api::ForeignTasksController < ApplicationController
  skip_before_filter :verify_authenticity_token

  before_filter :authenticate_user!
  before_filter :authorize_admin

  respond_to :json

  def create
    project = Project.find_by_remote_id(params[:remote_project_id])
    category = Category.where(:name => params[:category]).first_or_create
    task = project.tasks.where(:remote_id => params[:remote_task_id]).first_or_initialize

    if task.new_record?
      task.attributes = {
        :name => params[:name],
        :category => category,
        :hours => params[:hours],
        :started_at => params[:started_at],
      }

      if task.save
        render :json => task
      else
        render :json => {:error => "Unable to findor create project"}
      end
    else
      render :json => task
    end
  end

  private

  def authorize_admin
    unless current_user.admin?
      render :json => {:error => "unauthorized access"}
      return
    end
  end
end
