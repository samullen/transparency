class Project < ActiveRecord::Base
  validates :user_id, :presence => true
  validates :name, :presence => true
end
