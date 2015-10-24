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

  test "start a project" do
  	@project = Fabricate(:project)
  	@user = Fabricate(:user)
  	post :start, id: @project.id, format: :json
    assert_response :success
    assert_includes response.body, "success"
  end

  test "project checkin" do
    @project = Fabricate(:project, lat: 100.0, lon: 100.0)
    @puzzle = Fabricate(:puzzle, project_id: @project.id)
    post :checkin, id: @project.id, coordinates: [100.0, 100.0],format: :json
    assert_response :success
  end

  test "project validate" do
    @project = Fabricate(:project)
    @user = User.first
    @puzzle = Fabricate(:puzzle, project_id: @project.id)
    @parti = Fabricate(:participation, user_id: @user.id, project_id: @project.id)
    post :validate, id: @project.id, answer: "MyString",format: :json
    assert_response :success
  end

end
