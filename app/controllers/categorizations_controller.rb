class CategorizationsController < ApplicationController

def create
  if params[:categorization][:article_id]
    a_categorization = ArticlesCategory.new(params[:categorization])
    authorize! :create, a_categorization

    a_categorization.save if ArticlesCategory.where(:article_id => a_categorization.article_id,
                                                    :category_id => a_categorization.category_id).blank?
    @article = Article.find(a_categorization.article_id)
    @obj = @article
  elsif params[:categorization][:gallery_id]
    g_categorization = CategoriesGallery.new(params[:categorization])
    authorize! :create, g_categorization

    g_categorization.save if CategoriesGallery.where(:gallery_id => g_categorization.gallery_id,
                                                     :category_id => g_categorization.category_id).blank?
    @gallery = Gallery.find(g_categorization.gallery_id)
    @obj = @gallery
  end
  render "create.js.erb"
end

end