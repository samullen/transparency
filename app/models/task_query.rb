class TaskQuery
  def range_of_months(projects)
    relation = Task.where(:project_id => projects.map(&:id))
    relation.pluck(:started_at).map {|d| d.beginning_of_month.to_date}.uniq
  end
end
