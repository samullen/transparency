class DashboardPage
  include Capybara::DSL

  def has_project_breakdown?
    project_breakdown.present?
  end

  def project_breakdown_rows
    project_breakdown.all("tbody > tr")
  end

  def project_breakdown
    find "#project-breakdown"
  end
end
