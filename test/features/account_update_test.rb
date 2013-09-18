$LOAD_PATH.unshift(File.expand_path("../..", __FILE__))
require "test_helper"

feature "Edit Account Feature Test" do
  scenario "Successful password change" do
    user_factory = UserFactory.new
    user = user_factory.create
    account_page = AccountPage.new

    visit edit_user_path

    account_page.change_password("new_password")
    account_page.submit

    current_path.must_equal root_path
    page.must_have_content "success"
  end
end
