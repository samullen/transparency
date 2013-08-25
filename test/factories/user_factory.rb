class UserFactory
  def initialize
    @sequence = 0
  end
  
  def build(options=nil)
    options = {
      :email => "user#{self.sequence}@example.com",
      :password => "password",
      :password_confirmation => "password",
    }.merge(options || {})

    User.new(options)
  end

  def create(options=nil)
    user = self.build(options || {})
    user.save
    user
  end

  def sequence
    @sequence += 1
  end
end
