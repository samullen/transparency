require "test_helper"

describe User do
  before do
    @user = User.new(:email => "user@example.com", :password => '123123123')
  end

  it "must be valid" do
    @user.must_be :valid?
  end
end
