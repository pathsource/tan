class ProjectsController < ApplicationController
  
  def index
    @projects = Project.all
  end

  def start
    @project = Project.find(params[:id])
    @user = User.first
    # @parti = Participation.find_or_initialize_by(project_id: @project.id, user_id: @user.id)
    @parti = @user.participations.create(project_id: @project.id, status: 'doing')
    render json: { success: true }
  end

  def checkin
    @project = Project.find(params[:id])
    @user = User.first
    if @project.distance <= 2
      render json: { success: true, content: @project.puzzle.answer, hit: @project.puzzle.hint }
    else
      render json: { success: false }
    end
  end

  def validate
    @project = Project.find(params[:id])
    @user = User.first
    if @project.puzzle.answer == params[:answer]
      @parti = @user.participations.find_by(project_id: @project.id)
      @parti.update(status: 'finished')
      render json: { success: true }
    else
      renser json: { success: false }
    end
  end

end