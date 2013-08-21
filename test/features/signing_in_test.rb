$LOAD_PATH.unshift(File.expand_path("../..", __FILE__))
require "test_helper"

feature "Signing in Feature Test" do
  scenario "Successful signin" do
    user = User.create(:email => "user@example.com", :password => "123123123", :password_confirmation => "123123123")
    
    visit root_path
    SigninPage.signin_user(user)
    current_path.must_equal dashboard_path
  end
end
