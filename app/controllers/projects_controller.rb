class ProjectsController < ApplicationController
  
  def index
    @projects = []
    address_order.each {|x| @projects << Project.find_by(address: x)}
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

  def result
    @project = Project.find(params[:id])
  end

  private
  def address_order
    if params[:type] == 'walking'
      ['青年大教堂', '红楼', '省博', '黄鹤楼', '武汉大学', '昙华林']
    elsif params[:type] == 'bicycle'
      %w(武汉大学 昙华林 黄鹤楼 省博 青年大教堂 红楼)
    else
      %w(黄鹤楼 省博 昙华林 红楼 青年大教堂 武汉大学)
    end
  end

end