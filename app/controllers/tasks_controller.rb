class TasksController < ApplicationController

  before_action :set_organization
  before_action :set_project
  before_action :set_task, only: [:show, :edit, :update, :destroy]

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
    render :index
  end

  def edit
  end

  def show
  end

  def new

    @task = @project.tasks.new
  end

  def update
    if @task.update(task_params)
      redirect_to organization_project_task_path(@organization, @project, @task), notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to organization_project_tasks_path(@organization, @project), notice: 'Task was successfully deleted.'
  end

  def create
    @task = @project.tasks.new(task_params)
    if @task.save
      redirect_to organization_project_task_path(@organization, @project, @task), notice: 'Task was successfully created.'
    else
      render :new
    end
  end 


  private

  def task_params
    params.require(:task).permit(:title, :description, :status, :due_date, :priority  )
  end

  def set_organization
    @organization = Organization.find(params[:organization_id])
  end

  def set_project
    @project = @organization.projects.find(params[:project_id])
  end

    def set_task
    @task = @project.tasks.find(params[:id])
  end

end