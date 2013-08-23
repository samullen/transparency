class ProjectAnalytic
  attr_accessor :project_windows

  def initialize(project_windows)
    @project_windows = project_windows
  end

  def total_hours
    project_windows.sum {|pw| pw.total_hours}
  end
end
