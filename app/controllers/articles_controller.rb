class ArticlesController < ApplicationController
  before_filter :set_article, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  # GET /articles
  # GET /articles.json
  def index
    @categories = Category.all
    unless params[:category].blank? || params[:category] == 'All'
      @articles = Article.joins(:articles_categories)
                         .where('articles_categories.category_id' => params[:category])
                         .sort_by(params[:sort])
                         .page(params[:page])
                         .per(params[:per])
    else
      @articles = Article.page(params[:page]).per(params[:per])
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = current_user.articles.new(params[:article])
    params[:category] ? category_ids = params[:category][:id_check] : category_ids = []

    respond_to do |format|
      if @article.save
        category_ids.each do |category_id|
          @article.categories << Category.find(category_id)
        end

        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render action: 'show', status: :created, location: @article }
      else
        format.html { render action: 'new' }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

end
