class ArticlesCategory < ActiveRecord::Base
  belongs_to :article
  belongs_to :category
  # attr_accessible :title, :body
end
