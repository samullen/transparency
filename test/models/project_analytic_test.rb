$LOAD_PATH.unshift(File.expand_path("../..", __FILE__))
require "test_helper"

describe ProjectAnalytic do
  describe "Initialization" do
    it "takes a collection of projects" do
      ProjectAnalytic.new([Object.new]).must_be_instance_of ProjectAnalytic
    end

    it "raises an error with wrong parameters" do
      proc { ProjectAnalytic.new }.must_raise ArgumentError
    end
  end

  describe "#total_hours" do
    it "returns the total number of hours across all projects" do
      project_windows = Array.new
      3.times do |i|
        project = Project.new(:name => "Example Project #{i}")
        def project.tasks 
          [Task.new(:hours => 3),Task.new(:hours => 3),Task.new(:hours => 4.5)]
        end
        project_windows << ProjectWindow.new(project)
      end

      project_analytic = ProjectAnalytic.new(project_windows)

      project_analytic.total_hours.must_equal 31.5
    end
  end
end
