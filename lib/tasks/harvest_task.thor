class HarvestTask < Thor
  desc "load_projects", "Import projects from Harvest"
  def load_projects
    require File.expand_path('config/environment.rb')

    harvest_client.projects.all.each do |harvest_project|
      user = User.find_by_remote_id(harvest_project.client_id.to_s)
      next unless user

      project = user.projects.where(:remote_id => harvest_project.id.to_s).first_or_initialize
      project.name = harvest_project.name

      project.save
    end
  end

  desc "load_tasks", "Import tasks from harvest"
  def load_tasks(date=nil)
    require File.expand_path('config/environment.rb')

    date ||= 1.day.ago

    harvest_client.time.all(date).each do |htask|
      project = Project.find_by_remote_id(htask.project_id.to_s)
      next unless project

      category = Category.where(:name => htask.task).first_or_create
      task = project.tasks.where(:remote_id => htask.id.to_s).first_or_initialize

      task.attributes = {
        :name => htask.notes,
        :category => category,
        :hours => htask.hours,
        :started_at => htask.created_at
      }

      task.save
    end
  end

  private 

  def harvest_client
    @harvest_client ||= Harvest.client(ENV['HARVEST_SUBDOMAIN'], ENV["HARVEST_USERNAME"], ENV["HARVEST_PASSWORD"])
  end
end
