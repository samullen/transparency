class ProjectPage
  include Capybara::DSL

  def has_task_breakdown?
    task_breakdown.present?
  end

  def task_breakdown_rows
    task_breakdown.all("tbody > tr")
  end

  def task_breakdown
    find "#task-breakdown"
  end
end
