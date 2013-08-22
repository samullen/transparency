class ProjectWindow
  attr_accessor :project, :timeframe

  def initialize(project, timerange=nil)
    @project = project
    @timeframe ||= Timeframe.new(Time.now.beginning_of_month, Time.now.end_of_month)
  end

  def total_hours
    self.tasks.sum {|t| t.hours}
  end

  def hours_by_day
    @hours_by_day ||= self.timeframe.map do |time|
      self.tasks.find_all {|t| 
        t.started_at.strftime("%Y%m%d") == time.strftime("%Y%m%d")
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
