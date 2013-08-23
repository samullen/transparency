require "test_helper"

describe Task do
  before do
    @task = Task.new(:project_id => 1001, :name => "Example Task")
  end

  it "must be valid" do
    @task.must_be :valid?
  end
end
