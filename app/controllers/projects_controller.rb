class ProjectsController < ApplicationController
  
  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
  end

  def start
    @project = Project.find(params[:id])
    # @user = User.first
    # @parti = Participation.find_or_initialize_by(project_id: @project.id, user_id: @user.id)
    @parti = Participation.create(project_id: @project.id, status: 'doing')
    render json: { success: true }
  end

  def checkin
    @project = Project.find(params[:id])
    # @user = User.first
    if @project.distance([params[:coordinates].try(&:first).to_f, params[:coordinates].try(&:last).to_f]) <= 2
      @parti = Participation.where(project_id: @project.id).order(:id).last
      @parti.update(status: 'arrived')
      render json: { success: true, content: @project.puzzle.answer, hint: @project.puzzle.hint }
    else
      render json: { success: false }
    end
  end

  def validate
    @project = Project.find(params[:id])
    # @user = User.first
    if @project.puzzle.answer == params[:answer]
      @parti = Participation.where(project_id: @project.id).order(:id).last
      @parti.update(status: 'finished')
      render json: { success: true }
    else
      renser json: { success: false }
    end
  end

end