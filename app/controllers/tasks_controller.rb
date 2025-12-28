class TasksController < ApplicationController
  
  before_action :set_organization
  before_action :set_project
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_organization_user, only: [:new, :edit, :create, :update, :index, :search]  
  before_action :set_available_tags, only: [:new, :edit, :create, :update, :index, :search]
  # GET /organizations/:organization_id/projects/:project_id/tasks
  def index
    @tasks = @project.tasks

    # Sorting
    @tasks = apply_sorting(@tasks)
    @tasks = @tasks.paginate(page: params[:page])
  end

  # POST /organizations/:organization_id/projects/:project_id/tasks/search
  def search
    @tasks = @project.tasks

    @tasks = apply_search_and_filter(@tasks)
    @tasks = apply_sorting(@tasks)

    @tasks = @tasks.paginate(page: params[:page])
    render :index
  end

  def edit
  end

  def show
  end

  def new

    @task = @project.tasks.new
    # @organization_users = @organization.users
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
    params.require(:task).permit(:title, :description, :status, :due_date, :priority, :assignee_id, tag_ids: []) 
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

  def set_organization_user
    @organization_users = @organization.users
  end

    def apply_sorting(tasks)
    sort_column = %w[title status priority].include?(params[:sort]) ? params[:sort] : "created_at"
    sort_direction = %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
    
    if params[:sort] == "assignee_id"
      tasks.sorted_by_assignee_email(sort_direction)
    else
      tasks.order("#{sort_column} #{sort_direction}")
    end
    end
    def apply_search_and_filter(tasks)
      if params[:search].present?
         tasks = tasks.searched_by_title(params[:search])
      end

      if params[:status].present?
        tasks = tasks.filter_by_status(params[:status])
        
      end

      if params[:priority].present?
        tasks = tasks.filter_by_priority(params[:priority])
      end

      if params[:due_date].present?
        tasks = tasks.filter_by_duedate(params[:due_date])
      end

      
        tasks = tasks.filter_by_assignee(params[:assignee_id])
      


      if params[:tag_id].present?
        tasks = tasks.filter_by_tag(params[:tag_id])
      end

      tasks
    end

    def set_available_tags
      @available_tags = Tag.all
    end

end