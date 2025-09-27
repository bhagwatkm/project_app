class TasksController < ApplicationController
  before_action :set_organization
  before_action :set_project
  before_action :set_task, only: %i[ show edit update destroy ]

  # GET /organizations/:organization_id/projects/:project_id/tasks
  def index
    # @tasks = @project.tasks
    @tasks = @project.tasks.paginate(page: params[:page], per_page: 2)
    # @projects = @organization.projects.paginate(page:params[:page], per_page:2).order(name: :desc)

  end

  # GET /organizations/:organization_id/projects/:project_id/tasks/:id
  def show
  end

  # GET /organizations/:organization_id/projects/:project_id/tasks/new
  def new
    @task = @project.tasks.new
  end

  # GET /organizations/:organization_id/projects/:project_id/tasks/:id/edit
  def edit
  end

  # POST /organizations/:organization_id/projects/:project_id/tasks
  def create
    @task = @project.tasks.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to organization_project_task_path(@organization, @project, @task), notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: organization_project_task_path(@organization, @project, @task) }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organizations/:organization_id/projects/:project_id/tasks/:id
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to organization_project_task_path(@organization, @project, @task), notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: organization_project_task_path(@organization, @project, @task) }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/:organization_id/projects/:project_id/tasks/:id
  def destroy
    @task.destroy!
    respond_to do |format|
      format.html { redirect_to organization_project_tasks_path(@organization, @project), status: :see_other, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_organization
      @organization = Organization.find(params[:organization_id])
    end

    def set_project
      @project = @organization.projects.find(params[:project_id])
    end

    def set_task
      @task = @project.tasks.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title, :description, :due_date, :status, :priority)
    end
end