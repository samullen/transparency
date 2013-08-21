require "test_helper"

describe Project do
  before do
    @project = Project.new
  end

  it "must be valid" do
    @project.valid?.must_equal true
  end
end
