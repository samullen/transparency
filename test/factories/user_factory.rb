class UserFactory
  def initialize
    @sequence = 0
  end
  
  def build(options={})
    options = {
      :email => "user#{self.sequence}@example.com",
      :password => "password",
      :password_confirmation => "password",
    }.merge(options)

    User.new(options)
  end

  def create(options={})
    user = build(options)
    user.save
    user
  end

  def sequence
    @sequence += 1
  end
end
