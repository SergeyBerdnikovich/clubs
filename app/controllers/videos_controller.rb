class VideosController < ApplicationController
  before_filter :set_video, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  # GET /videos
  # GET /videos.json
  def index
    @categories = Category.all

    unless params[:category].blank? || params[:category] == 'All'
      @videos = Video.joins(:categories_videos)
                     .where('categories_videos.category_id' => params[:category])
                     .sort_by(params[:sort])
                     .page(params[:page])
                     .per(params[:per])
    else
      @videos = Video.sort_by(params[:sort]).page(params[:page]).per(params[:per])
    end
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
  end

  # GET /videos/new
  def new
    @video = Video.new
  end

  # GET /videos/1/edit
  def edit
  end

  # POST /videos
  # POST /videos.json
  def create
    @video = current_user.videos.new(params[:video])

    respond_to do |format|
      if @video.save
        @video.categories << Category.find(params[:category_id])

        format.html { redirect_to @video, notice: 'Video was successfully created.' }
        format.json { render action: 'show', status: :created, location: @video }
      else
        format.html { render action: 'new' }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /videos/1
  # PATCH/PUT /videos/1.json
  def update
    respond_to do |format|
      if @video.update_attributes(params[:video])
        format.html { redirect_to @video, notice: 'Video was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video.destroy
    respond_to do |format|
      format.html { redirect_to videos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end
end
