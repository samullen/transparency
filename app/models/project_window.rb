class ProjectWindow
  attr_accessor :project, :daterange

  def initialize(project, daterange=nil)
    @project = project
    @daterange ||= Daterange.new(Time.now.beginning_of_month, Time.now.end_of_month)
  end

  def self.for_projects(projects, daterange=nil)
    projects.map {|project| self.new(project, daterange)}
  end

  def total_hours
    self.tasks.sum {|t| t.hours}
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

  def tasks
    @tasks ||= self.project.tasks
  end
end
