class Category < ActiveRecord::Base
  attr_accessible :name, :parent_id

  has_many :articles_categories
  has_many :articles, through: :articles_categories

  has_many :categories_galleries
  has_many :galleries, through: :categories_galleries

  has_many :categories_videos
  has_many :galleries, through: :categories_videos
end
