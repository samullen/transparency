$LOAD_PATH.unshift(File.expand_path("../..", __FILE__))
require "test_helper"

describe User do
  describe "#admin?" do
    it "is true if role == 'admin'" do
      user = User.new(:role => 'admin')
      user.must_be :admin?
    end

    it "is false if role != 'admin'" do
      user = User.new(:role => 'general')
      user.wont_be :admin?
    end
  end
end
