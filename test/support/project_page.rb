class ProjectPage
  include Capybara::DSL

  def has_task_breakdown?
    project_breakdown.present?
  end

  def task_breakdown_rows
    project_breakdown.all("tbody > tr")
  end

  def task_breakdown
    find "#task-breakdown"
  end
end
