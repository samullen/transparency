$LOAD_PATH.unshift(File.expand_path("../..", __FILE__))
require "test_helper"

describe Category do
  before do
    @category = Category.new(:name => "example name")
  end

  it "must be valid" do
    @category.must_be :valid?
  end
end
