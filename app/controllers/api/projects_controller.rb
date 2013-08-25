class Api::ProjectsController < ApplicationController
  before_filter :authenticate_user!

  def create
    user = User.find_by_remote_id(params[:remote_client_id])
    project = user.projects.find_or_initialize_by(remote_id: params[:remote_project_id], name: params[:name])

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
end
