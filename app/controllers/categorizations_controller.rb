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

end