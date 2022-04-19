require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  test "#project_files isEmpty" do
    project = create(:project)
    assert project.project_files.empty?
  end
end
