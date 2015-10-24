require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "get projects list" do
  	get :index
  	assert_response :success
  end

end
