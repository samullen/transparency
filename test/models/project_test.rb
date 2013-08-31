$LOAD_PATH.unshift(File.expand_path("../..", __FILE__))
require "test_helper"

describe Project do
  describe "::accessible_by" do
    before do
      project_factory = ProjectFactory.new
      @user = OpenStruct.new(:id => 1001, :admin? => false)
      @owned_project = project_factory.create(:user_id => 1001)
      @unowned_project = project_factory.create(:user_id => 2002)
    end

    it "includes projects only belonging to a user" do
      Project.accessible_by(@user).must_include @owned_project
    end

    it "excludes projects not owned by a user" do
      Project.accessible_by(@user).wont_include @unowned_project
    end

    it "incldues all projects if user is an admin" do
      admin = OpenStruct.new(:id => 1, :admin? => true)
      Project.accessible_by(admin).must_include @owned_project
      Project.accessible_by(admin).must_include @unowned_project
    end
  end
end
