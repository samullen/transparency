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
      project_window.timeframe.start_time.must_equal sdate
      project_window.timeframe.end_time.must_equal edate
    end
  end

  describe "#total_hours" do
    it "returns the sum of hours for all tasks" do
      project = Project.new
      tasks = [
        Task.new(:hours => 3),
        Task.new(:hours => 3),
        Task.new(:hours => 4.5),
      ]

      project_window = ProjectWindow.new(project)
      project.stub :tasks, tasks do
        project_window.total_hours.must_equal 10.5
      end
    end
  end

  describe "#hours_by_day" do
    it "returns the sum of hours for all tasks" do
      project = Project.new
      tasks = [
        Task.new(:hours => 3, :started_at => "2013-08-03"),
        Task.new(:hours => 3, :started_at => "2013-08-05"),
        Task.new(:hours => 4.5, :started_at => "2013-08-08"),
      ]
      timeframe = Timeframe.new(Time.parse('2013-08-01'), Time.parse('2013-08-31'))

      project_window = ProjectWindow.new(project, timeframe)
      project.stub :tasks, tasks do
        project_window.hours_by_day.must_equal [0, 0, 3.0, 0, 3.0, 0, 0, 4.5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
      end
    end
  end

  describe "#average_hours" do
    it "returns the average number of hours per month" do
      project = Project.new
      tasks = [
        Task.new(:hours => 3),
        Task.new(:hours => 3),
        Task.new(:hours => 4.5),
      ]

      project_window = ProjectWindow.new(project)
      project.stub :tasks, tasks do
        project_window.average_hours.must_equal 3.5
      end
    end
  end
end
