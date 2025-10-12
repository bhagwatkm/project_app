class TasksController < ApplicationController
  before_action :set_organization
  before_action :set_project

  # GET /organizations/:organization_id/projects/:project_id/tasks
  def index
    @tasks = @project.tasks

    # Sorting
    sort_column = %w[title status].include?(params[:sort]) ? params[:sort] : "created_at"
    sort_direction = %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
    @tasks = @tasks.order("#{sort_column} #{sort_direction}")

    @tasks = @tasks.paginate(page: params[:page])
  end

  # POST /organizations/:organization_id/projects/:project_id/tasks/search
  def search
     @tasks = @project.tasks

    # Search by title
    if params[:search].present?
      @tasks = @tasks.where("title LIKE ?", "%#{params[:search]}%")
    end

    # Filter by status
    if params[:status].present?
      @tasks = @tasks.where(status: params[:status])
    end
    @tasks = @tasks.paginate(page: params[:page])
  end

  private

  def set_organization
    @organization = Organization.find(params[:organization_id])
  end

  def set_project
    @project = @organization.projects.find(params[:project_id])
  end
end