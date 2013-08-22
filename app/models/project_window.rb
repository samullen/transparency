class ProjectWindow
  attr_accessor :project, :start_date, :end_date

  def initialize(project, timerange=nil)
    @project = project
    timerange ||= Time.now.beginning_of_month .. Time.now.end_of_month
    @start_date = timerange.first
    @end_date = timerange.last
  end
end
