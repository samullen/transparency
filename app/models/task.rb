class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :category

  validates :project_id, :presence => true
  validates :name, :presence => true
end
