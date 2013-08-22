$LOAD_PATH.unshift(File.expand_path("../..", __FILE__))
require "test_helper"

describe ProjectWindow do
  describe "Initialization" do
    it "requires a project" do
      ProjectWindow.new(Object.new).must_be_instance_of ProjectWindow
    end

    it "can take a timeframe" do
      ProjectWindow.new(Object.new, 0..10).must_be_instance_of ProjectWindow
    end

    it "defaults the timeframe to the current month" do
      sdate = Time.now.beginning_of_month
      edate = Time.now.end_of_month
      project_window = ProjectWindow.new(Object.new)
      project_window.start_date.must_equal sdate
      project_window.end_date.must_equal edate
    end
  end

  describe "#total_hours" do
  end

  describe "#hours_by_day" do
  end

  describe "#average_hours" do
  end
end
