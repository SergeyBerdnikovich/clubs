class CategoriesGallery < ActiveRecord::Base
  belongs_to :category
  belongs_to :gallery
  # attr_accessible :title, :body
end
