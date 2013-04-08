require 'sanitize/sanitize.rb'
class Article < ActiveRecord::Base
  attr_accessible :description, :full_text, :title , :categories_attributes

  has_many :articles_categories
  has_many :categories, through: :articles_categories
  has_many :comments, as: :commentable
  belongs_to :user

  before_create :sanitize_input

  private

  def sanitize_input
    self.full_text = TunedSanitize::for_(self.full_text)
  end
end
