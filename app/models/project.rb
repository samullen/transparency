class Project < ActiveRecord::Base
  belongs_to :user

  has_many :tasks, :dependent => :destroy

  validates :user_id, :presence => true
  validates :name, :presence => true

  def self.accessible_by(user)
    user.admin? ? self.all : self.where("user_id = ?", user.id)
  end
end
