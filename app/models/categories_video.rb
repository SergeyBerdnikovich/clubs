class CategoriesVideo < ActiveRecord::Base
  belongs_to :category
  belongs_to :video

  attr_accessible :category_id, :video_id
end
