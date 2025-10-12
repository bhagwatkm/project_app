class ProjectsController < ApplicationController
  before_action :set_organization
  before_action :set_project, only: %i[ show edit update destroy ]

  # GET /organizations/:organization_id/projects
  def index
    @projects = @organization.projects.paginate(page:params[:page], per_page:2).order(name: :desc)
  end

  # GET /organizations/:organization_id/projects/:id
  def show
  end

  # GET /organizations/:organization_id/projects/new
  def new
    @project = @organization.projects.new
  end


  def clone
    clone_project = @organization.projects.find(params[:id])
    @project = @organization.projects.new(name: "#{clone_project.name} Copy", description: clone_project.description, status: clone_project.status)
    render :new
  end

  # GET /organizations/:organization_id/projects/:id/edit
  def edit
  end

  # POST /organizations/:organization_id/projects
  def create
    @project = @organization.projects.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to [@organization, @project], notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: [@organization, @project] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end


  def show
    @tasks = @project.tasks.order(updated_at: :desc).limit(5)
  end

  # PATCH/PUT /organizations/:organization_id/projects/:id
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to [@organization, @project], notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: [@organization, @project] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/:organization_id/projects/:id
  def destroy
    @project.destroy!
    respond_to do |format|
      format.html { redirect_to organization_path(@organization), status: :see_other, notice: "Project was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_organization
      @organization = Organization.find(params[:organization_id])
    end

    def set_project
      @project = @organization.projects.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:name, :description, :status)
    end
end