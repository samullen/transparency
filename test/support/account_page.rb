class AccountPage
  include Capybara::DSL

  def change_password(new_password)
    fill_in :password, :with => new_password
    fill_in :password_confirmation, :with => new_password
  end

  def submit
    click_button "Sign in"
  end
end
