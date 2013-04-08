class CategoriesGallery < ActiveRecord::Base
  belongs_to :category
  belongs_to :gallery

  attr_accessible :category_id, :gallery_id
end
