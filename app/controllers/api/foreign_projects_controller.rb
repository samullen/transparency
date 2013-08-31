class Api::ForeignProjectsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  before_filter :authenticate_user!
  before_filter :authorize_admin

  respond_to :json

  def create
    user = User.find_by_remote_id(params[:remote_client_id])
    project = user.projects.find_or_initialize_by(remote_id: params[:remote_project_id], name: params[:name])

    if project.new_record?
      if project.save
        respond_with project
      else
        render :json => {:error => "Unable to findor create project"}
      end
    else
      respond_with project
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
