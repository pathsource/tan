require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "get projects list" do
  	10.times {
  		Fabricate(:project)
  	}
  	get :index, format: :json
  	assert_response :success
  end

  test "" do
  	@project = Fabricate(:project)
  	# @user = Fabircate()
  	post :start, id: @project.id
  end

end
