class Project < ActiveRecord::Base
  belongs_to :user

  has_many :tasks, :dependent => :destroy

  validates :user_id, :presence => true
  validates :name, :presence => true

  def self.accessible_by(user)
    user.admin? ? self.all : self.where("user_id = ?", user.id)
  end

  def self.active_for_daterange(daterange)
    arel = self.joins(:tasks)
    arel = arel.where(:tasks => {:started_at => daterange.start_date..daterange.end_date})
    arel = arel.distinct
  end
end
