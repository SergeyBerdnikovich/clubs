class GalleriesController < ApplicationController
  before_filter :set_gallery, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  # GET /galleries
  # GET /galleries.json
  def index
    @categories = Category.all

    unless params[:category].blank? || params[:category] == 'All'
      @galleries = Gallery.joins(:categories_galleries)
                          .where('categories_galleries.category_id' => params[:category])
                          .sort_by(params[:sort])
                          .page(params[:page])
                          .per(params[:per])
    else
      @galleries = Gallery.sort_by(params[:sort]).page(params[:page]).per(params[:per])
    end
  end

  # GET /galleries/1
  # GET /galleries/1.json
  def show
  end

  # GET /galleries/new
  def new
    @gallery = Gallery.new
  end

  # GET /galleries/1/edit
  def edit
  end

  # POST /galleries
  # POST /galleries.json
  def create
    @gallery = current_user.galleries.new(params[:gallery])

    respond_to do |format|
      if @gallery.save
        @gallery.categories << Category.find(params[:category_id]) if params[:category_id]

        format.html { redirect_to @gallery, notice: 'Gallery was successfully created.' }
        format.json { render action: 'show', status: :created, location: @gallery }
      else
        format.html { render action: 'new' }
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /galleries/1
  # PATCH/PUT /galleries/1.json
  def update
    respond_to do |format|
      if @gallery.update_attributes(params[:gallery])
        format.html { redirect_to @gallery, notice: 'Gallery was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /galleries/1
  # DELETE /galleries/1.json
  def destroy
    @gallery.destroy
    respond_to do |format|
      format.html { redirect_to galleries_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gallery
      @gallery = Gallery.find(params[:id])
    end
end
