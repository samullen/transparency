$LOAD_PATH.unshift(File.expand_path("../..", __FILE__))
require "test_helper"

describe Project do
  before do
    @project = Project.new(:name => "Example Project", :user_id => 1001)
  end

  it "must be valid" do
    @project.valid?.must_equal true
  end
end
