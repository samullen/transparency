class Api::ForeignProjectsController < ApplicationController
  respond_to :json

  skip_before_filter :verify_authenticity_token

  before_filter :authenticate_user!
  before_filter :authorize_admin

  def create
    user = User.find_by_remote_id(params[:remote_client_id])
    project = user.projects.where(remote_id: params[:remote_project_id], name: params[:name]).first_or_initialize

    if project.new_record?
      if project.save
        render :json => project.to_json
      else
        render :json => {:error => "Unable to findor create project"}
      end
    else
      render :json => project.to_json
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
