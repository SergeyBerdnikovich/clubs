class ArticlesCategory < ActiveRecord::Base
  belongs_to :article
  belongs_to :category

  attr_accessible :category_id, :article_id
end
