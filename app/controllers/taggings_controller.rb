class TaggingsController < ApplicationController
  before_action :set_tagging, only: %i[ show edit update destroy ]

  # GET /taggings or /taggings.json
  def index
    @taggings = Tagging.all
  end

  # GET /taggings/1 or /taggings/1.json
  def show
  end

  # GET /taggings/new
  def new
    @tagging = Tagging.new
  end

  # GET /taggings/1/edit
  def edit
  end

  # POST /taggings or /taggings.json
  def create
    @tagging = Tagging.new(tagging_params)

    respond_to do |format|
      if @tagging.save
        format.html { redirect_to @tagging, notice: "Tagging was successfully created." }
        format.json { render :show, status: :created, location: @tagging }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tagging.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /taggings/1 or /taggings/1.json
  def update
    respond_to do |format|
      if @tagging.update(tagging_params)
        format.html { redirect_to @tagging, notice: "Tagging was successfully updated." }
        format.json { render :show, status: :ok, location: @tagging }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tagging.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /taggings/1 or /taggings/1.json
  def destroy
    @tagging.destroy!

    respond_to do |format|
      format.html { redirect_to taggings_path, status: :see_other, notice: "Tagging was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tagging
      @tagging = Tagging.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def tagging_params
      params.expect(tagging: [ :tag_id, :taggable_type, :taggable_id ])
    end
end
