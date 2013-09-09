$LOAD_PATH.unshift(File.expand_path("../..", __FILE__))
require "test_helper"

describe ProjectWindow do
  describe "Initialization" do
    it "requires a project" do
      ProjectWindow.new(Object.new).must_be_instance_of ProjectWindow
    end

    it "can take a daterange" do
      ProjectWindow.new(Object.new, 0..10).must_be_instance_of ProjectWindow
    end

    it "defaults the daterange to the current month" do
      sdate = Date.today.beginning_of_month
      edate = sdate.end_of_month
      project_window = ProjectWindow.new(Object.new)
      project_window.daterange.start_date.must_equal sdate
      project_window.daterange.end_date.must_equal edate
    end
  end

  describe "::for_projects" do
    before do
      @projects = [ Project.new, Project.new, Project.new ]
      @project_windows = ProjectWindow.for_projects(@projects)
    end

    it "creates a project window object for each project" do
      @project_windows.all? {|pw| pw.must_be_instance_of ProjectWindow}
    end

    it "creates the same number as projects passed in" do
      @project_windows.size.must_equal @projects.size
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
      project_window.stub :tasks, tasks do
        project_window.total_hours.must_equal 10.5
      end
    end
  end

  describe "#total_days" do
    it "returns the number of days in teh date range" do
      daterange = Daterange.new(Date.today, Date.today + 14)
      project_window = ProjectWindow.new(Project.new, daterange)
      project_window.total_days.must_equal 15
    end
  end

  describe "#tasks_for_date" do
    before do
      @project = Project.new
      @tasks = [
        Task.new(:hours => 3, :started_at => "2013-08-03"),
        Task.new(:hours => 3, :started_at => "2013-08-05"),
        Task.new(:hours => 4.5, :started_at => "2013-08-08"),
      ]
      @daterange = Daterange.new(Date.parse('2013-08-01'), Date.parse('2013-08-31'))

      @project_window = ProjectWindow.new(@project, @daterange)
    end

    it "returns tasks for a given date" do
      date = Date.parse("2013-08-03")

      @project_window.stub :tasks, @tasks do
        @project_window.tasks_for_date(date).must_include @tasks[0]
      end
    end

    it "does not include tasks of other dates" do
      date = Date.parse("2013-08-03")
      @project_window.stub :tasks, @tasks do
        @project_window.tasks_for_date(date).wont_include @tasks[1]
        @project_window.tasks_for_date(date).wont_include @tasks[2]
      end
    end
  end

  describe "#hours_by_day" do
    before do
      @project = Project.new
      @tasks = [
        Task.new(:hours => 3, :started_at => "2013-08-03"),
        Task.new(:hours => 3, :started_at => "2013-08-05"),
        Task.new(:hours => 4.5, :started_at => "2013-08-08"),
      ]
      @daterange = Daterange.new(Date.parse('2013-08-01'), Date.parse('2013-08-31'))

      @project_window = ProjectWindow.new(@project, @daterange)
    end

    it "returns an array the same size as the days in the daterange" do
      @project_window.hours_by_day.size.must_equal 31
    end

    it "returns the sum of hours for all tasks" do
      @project_window.stub :tasks, @tasks do
        @project_window.hours_by_day[2].must_equal 3.0
        @project_window.hours_by_day[4].must_equal 3.0
        @project_window.hours_by_day[7].must_equal 4.5
      end
    end
  end

  describe "#tasks_by_date" do
    before do
      @project = Project.new
      @tasks = [
        Task.new(:hours => 3, :started_at => "2013-08-03"),
        Task.new(:hours => 3, :started_at => "2013-08-05"),
        Task.new(:hours => 4.5, :started_at => "2013-08-08"),
      ]
      @daterange = Daterange.new(Date.parse('2013-08-01'), Date.parse('2013-08-31'))

      @project_window = ProjectWindow.new(@project, @daterange)
    end

    it "returns collections of tasks for each day of the month" do
      @project_window.stub :tasks, @tasks do
        @project_window.tasks_by_date.must_include [@tasks[0]]
        @project_window.tasks_by_date.must_include [@tasks[1]]
        @project_window.tasks_by_date.must_include [@tasks[2]]
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
      project_window.stub :tasks, tasks do
        project_window.average_hours.must_equal 3.5
      end
    end
  end

  describe "#project_name" do
    it "returns the name of the project it represents" do
      project = Project.new(:name => "Example Project")
      project_window = ProjectWindow.new(project)
      project_window.project_name.must_equal project.name
    end
  end
end
