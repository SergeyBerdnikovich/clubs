class Category < ActiveRecord::Base
  attr_accessible :name

  has_many :articles_categories
  has_many :articles, through: :articles_categories

  has_many :categories_galleries
  has_many :galleries, through: :categories_galleries
end
