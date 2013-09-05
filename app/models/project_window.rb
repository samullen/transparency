class ProjectWindow
  attr_accessor :project, :daterange

  def initialize(project, daterange=nil)
    @project = project
    @daterange = daterange || Daterange.new(Time.now.beginning_of_month, Time.now.end_of_month)
  end

  def self.for_projects(projects, daterange=nil)
    projects.map {|project| self.new(project, daterange)}
  end

  def project_name
    self.project.name
  end

  def tasks
    @tasks ||= self.project.tasks.where(:started_at => @daterange.start_time .. @daterange.end_time)
  end

  def total_hours
    self.tasks.sum(:hours)
  end

  def total_days
    self.daterange.count
  end

  def hours_by_day
    @hours_by_day ||= self.daterange.map do |date|
      self.tasks.find_all {|t| 
        t.started_at.strftime("%Y%m%d") == date.strftime("%Y%m%d")
      }.sum {|t| t.hours}
    end
  end

  def average_hours
    self.total_hours / self.tasks.size
  end
end
