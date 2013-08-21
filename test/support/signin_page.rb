class SigninPage
  include Capybara::DSL

  attr_accessor :user

  def initialize(user)
    @user = user
  end

  def signin_user
    self.fill_in_email
    self.fill_in_password
    self.submit
  end

  def fill_in_email(email=nil)
    fill_in("Email", :with => email || self.user.email)
  end

  def fill_in_password(password=nil)
    fill_in("Password", :with => password || self.user.password)
  end

  def submit
    click_button "Sign in"
  end
end
