class CategorizationsController < ApplicationController

  def create
    if params[:categorization][:article_id]
      a_categorization = ArticlesCategory.new(params[:categorization])
      authorize! :create, a_categorization

      a_categorization.save if ArticlesCategory.where(:article_id  => a_categorization.article_id,
                                                      :category_id => a_categorization.category_id).blank?
      @obj = Article.find(a_categorization.article_id)
    elsif params[:categorization][:gallery_id]
      g_categorization = CategoriesGallery.new(params[:categorization])
      authorize! :create, g_categorization

      g_categorization.save if CategoriesGallery.where(:gallery_id  => g_categorization.gallery_id,
                                                       :category_id => g_categorization.category_id).blank?
      @obj = Gallery.find(g_categorization.gallery_id)
     elsif params[:categorization][:video_id]
      v_categorization = CategoriesVideo.new(params[:categorization])
      authorize! :create, v_categorization

      v_categorization.save if CategoriesVideo.where(:video_id    => v_categorization.video_id,
                                                     :category_id => v_categorization.category_id).blank?
      @obj = Video.find(v_categorization.video_id)
    end
    render "create.js.erb"
  end

  def destroy
    if params[:delete] == 'Article'
      @a_categorization = ArticlesCategory.find_by_article_id_and_category_id(params[:id], params[:category_id])
      @a_categorization.destroy

      respond_to do |format|
        format.html { redirect_to edit_article_path(params[:id]) }
        format.json { head :no_content }
      end
    elsif params[:delete] == 'Gallery'
      @g_categorization = CategoriesGallery.find_by_gallery_id_and_category_id(params[:id], params[:category_id])
      @g_categorization.destroy

      respond_to do |format|
        format.html { redirect_to edit_gallery_path(params[:id]) }
        format.json { head :no_content }
      end
    elsif params[:delete] == 'Video'
      @v_categorization = CategoriesVideo.find_by_video_id_and_category_id(params[:id], params[:category_id])
      @v_categorization.destroy

      respond_to do |format|
        format.html { redirect_to edit_video_path(params[:id]) }
        format.json { head :no_content }
      end
    end
  end

end