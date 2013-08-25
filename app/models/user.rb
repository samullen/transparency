class User < ActiveRecord::Base

  devise :database_authenticatable, :recoverable, :rememberable, :trackable, 
         :validatable, :token_authenticatable

  has_many :projects

  before_create :ensure_authentication_token

  def admin?
    self.role == 'admin'
  end
end
