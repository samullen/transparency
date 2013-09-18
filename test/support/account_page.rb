class AccountPage
  include Capybara::DSL

  def change_password(new_password)
    fill_in "Password", :with => new_password
    fill_in "Password confirmation", :with => new_password
  end

  def submit
    click_button "Update"
  end
end
